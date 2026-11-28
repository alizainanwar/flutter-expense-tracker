import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/expense_controller.dart';
import '../models/expense.dart';
import '../screens/add_expense_screen.dart';

/// A single row in the expense list, with edit and delete actions.
class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Expense expense;

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'transport':
        return Icons.directions_bus;
      case 'shopping':
        return Icons.shopping_bag;
      case 'bills':
        return Icons.receipt_long;
      case 'entertainment':
        return Icons.movie;
      case 'health':
        return Icons.health_and_safety;
      default:
        return Icons.attach_money;
    }
  }

  void _confirmDelete() {
    Get.defaultDialog(
      title: 'Delete expense?',
      middleText: '"${expense.title}" will be removed.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.find<ExpenseController>().deleteExpense(expense.id);
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_iconForCategory(expense.category)),
        ),
        title: Text(expense.title),
        subtitle: Text(
          '${expense.category} • ${DateFormat.yMMMd().format(expense.date)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rs ${expense.amount.toStringAsFixed(0)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  Get.to(() => AddExpenseScreen(expense: expense));
                } else if (value == 'delete') {
                  _confirmDelete();
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

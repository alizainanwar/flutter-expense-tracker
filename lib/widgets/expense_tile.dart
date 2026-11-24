import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

/// A single row in the expense list.
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
        trailing: Text(
          'Rs ${expense.amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

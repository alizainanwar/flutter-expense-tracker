import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/expense_controller.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';
import '../widgets/total_spent_card.dart';
import 'add_expense_screen.dart';

/// Home screen: total spent card, category filter, expense list.
/// Day 3: reads expenses from ExpenseController (GetX); FAB opens the add form.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExpenseController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          final expenses = controller.filteredExpenses;
          final isFiltered = controller.selectedCategory.value != 'All';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TotalSpentCard(
                totalSpent: controller.totalSpent,
                count: controller.expenses.length,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'Recent expenses',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: controller.selectedCategory.value,
                      items: ['All', ...ExpenseCategories.all]
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) controller.setCategory(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: expenses.isEmpty
                    ? Center(
                        child: Text(
                          isFiltered
                              ? 'No expenses in this category.'
                              : 'No expenses yet. Tap + to add one.',
                        ),
                      )
                    : ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          return ExpenseTile(expense: expenses[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddExpenseScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

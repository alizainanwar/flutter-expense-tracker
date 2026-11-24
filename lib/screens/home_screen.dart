import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../widgets/expense_tile.dart';

/// Home screen: total spent card + list of expenses.
/// Day 1: UI skeleton with dummy data. Add-expense form arrives on Day 2.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Dummy data for the Day 1 skeleton — replaced by real state on Day 2/3.
  static final List<Expense> _dummyExpenses = [
    Expense(
      id: '1',
      title: 'Lunch at cafe',
      amount: 850,
      category: 'Food',
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      title: 'Bus fare',
      amount: 120,
      category: 'Transport',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Expense(
      id: '3',
      title: 'Mobile top-up',
      amount: 500,
      category: 'Bills',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  double get _totalSpent =>
      _dummyExpenses.fold(0, (sum, e) => sum + e.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Total spent card.
          Card(
            margin: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total spent this month',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rs ${_totalSpent.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_dummyExpenses.length} expenses',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Recent expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _dummyExpenses.length,
              itemBuilder: (context, index) {
                return ExpenseTile(expense: _dummyExpenses[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Day 2: opens the add-expense form.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add expense coming on Day 2'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

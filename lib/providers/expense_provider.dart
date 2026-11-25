import 'package:flutter/foundation.dart';

import '../models/expense.dart';

/// Simple state for the expense list. Day 2: in-memory only,
/// local storage arrives on Day 3.
class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _expenses = [
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

  List<Expense> get expenses => List.unmodifiable(_expenses);

  double get totalSpent => _expenses.fold(0, (sum, e) => sum + e.amount);

  void addExpense(Expense expense) {
    _expenses.insert(0, expense);
    notifyListeners();
  }
}

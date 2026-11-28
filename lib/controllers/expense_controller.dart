import 'package:get/get.dart';

import '../models/expense.dart';
import '../services/storage_service.dart';

/// Holds the expense list. Loads from local storage on start and
/// saves on every change, so expenses survive an app restart.
class ExpenseController extends GetxController {
  ExpenseController({StorageService? storage})
      : _storage = storage ?? StorageService();

  final StorageService _storage;

  final expenses = <Expense>[].obs;
  final selectedCategory = 'All'.obs;

  /// Expenses for the selected category, or all of them.
  List<Expense> get filteredExpenses {
    if (selectedCategory.value == 'All') return expenses;
    return expenses
        .where((e) => e.category == selectedCategory.value)
        .toList();
  }

  double get totalSpent => expenses.fold(0, (sum, e) => sum + e.amount);

  @override
  void onInit() {
    super.onInit();
    final saved = _storage.loadExpenses();
    if (saved.isEmpty) {
      // First run: show a few sample expenses, then save them.
      expenses.addAll(_sampleExpenses());
      _save();
    } else {
      expenses.addAll(saved);
    }
  }

  void addExpense(Expense expense) {
    expenses.insert(0, expense);
    _save();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  Future<void> _save() => _storage.saveExpenses(expenses);

  List<Expense> _sampleExpenses() {
    final now = DateTime.now();
    return [
      Expense(
        id: '1',
        title: 'Lunch at cafe',
        amount: 850,
        category: 'Food',
        date: now,
      ),
      Expense(
        id: '2',
        title: 'Bus fare',
        amount: 120,
        category: 'Transport',
        date: now.subtract(const Duration(days: 1)),
      ),
      Expense(
        id: '3',
        title: 'Mobile top-up',
        amount: 500,
        category: 'Bills',
        date: now.subtract(const Duration(days: 2)),
      ),
    ];
  }
}

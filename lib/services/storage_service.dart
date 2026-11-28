import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../models/expense.dart';

/// Tiny local storage helper: saves expenses as JSON so they
/// survive an app restart. One key, no extra setup.
class StorageService {
  static const _key = 'expenses';

  final _box = GetStorage();

  List<Expense> loadExpenses() {
    final raw = _box.read<String>(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list
        .map((item) => Expense.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    final raw = jsonEncode(expenses.map((e) => e.toMap()).toList());
    await _box.write(_key, raw);
  }
}

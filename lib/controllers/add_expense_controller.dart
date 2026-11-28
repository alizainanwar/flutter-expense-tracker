import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expense.dart';
import 'expense_controller.dart';

/// Form state for the add/edit-expense screen. The screen itself stays
/// a StatelessWidget; everything that changes lives here.
/// The same form is used for adding and editing — editing just
/// pre-fills it and saves an update instead of a new expense.
class AddExpenseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final category = ExpenseCategories.all.first.obs;
  final date = DateTime.now().obs;

  Expense? _editing;
  String? _preparedFor;

  bool get isEditing => _editing != null;

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    super.onClose();
  }

  /// Fill the form for [expense], or reset it for a new expense.
  /// Safe to call from the screen's build: it only runs once per
  /// expense (or once for a new expense).
  void prepare(Expense? expense) {
    final key = expense?.id ?? 'add';
    if (_preparedFor == key) return;
    _preparedFor = key;

    _editing = expense;
    if (expense == null) {
      titleController.clear();
      amountController.clear();
      category.value = ExpenseCategories.all.first;
      date.value = DateTime.now();
    } else {
      titleController.text = expense.title;
      amountController.text = expense.amount.toStringAsFixed(0);
      category.value = expense.category;
      date.value = expense.date;
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) date.value = picked;
  }

  void save() {
    if (!formKey.currentState!.validate()) return;

    final title = titleController.text.trim();
    final amount = double.parse(amountController.text.trim());

    if (_editing != null) {
      Get.find<ExpenseController>().updateExpense(
        _editing!.copyWith(
          title: title,
          amount: amount,
          category: category.value,
          date: date.value,
        ),
      );
    } else {
      Get.find<ExpenseController>().addExpense(
        Expense(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          amount: amount,
          category: category.value,
          date: date.value,
        ),
      );
    }

    _reset();
    Get.back();
  }

  void _reset() {
    _editing = null;
    _preparedFor = null;
    titleController.clear();
    amountController.clear();
    category.value = ExpenseCategories.all.first;
    date.value = DateTime.now();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/expense.dart';
import 'expense_controller.dart';

/// Form state for the add-expense screen. The screen itself stays
/// a StatelessWidget; everything that changes lives here.
class AddExpenseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final category = ExpenseCategories.all.first.obs;
  final date = DateTime.now().obs;

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    super.onClose();
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

    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text.trim(),
      amount: double.parse(amountController.text.trim()),
      category: category.value,
      date: date.value,
    );

    Get.find<ExpenseController>().addExpense(expense);
    _reset();
    Get.back();
  }

  void _reset() {
    titleController.clear();
    amountController.clear();
    category.value = ExpenseCategories.all.first;
    date.value = DateTime.now();
  }
}

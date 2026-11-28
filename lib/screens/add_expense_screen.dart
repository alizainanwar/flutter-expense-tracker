import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/add_expense_controller.dart';
import '../models/expense.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

/// Add-expense form: title, amount, category picker, date picker.
/// The same form edits an expense when one is passed in.
/// StatelessWidget — all form state lives in AddExpenseController.
class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key, this.expense});

  final Expense? expense;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddExpenseController());
    controller.prepare(expense);

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isEditing ? 'Edit Expense' : 'Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: controller.titleController,
                label: 'Title',
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Please enter a title'
                        : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.amountController,
                label: 'Amount (Rs)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  final amount = double.tryParse(value?.trim() ?? '');
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.category.value,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: ExpenseCategories.all
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) controller.category.value = value;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today),
                  title: Text(DateFormat.yMMMd().format(controller.date.value)),
                  trailing: TextButton(
                    onPressed: () => controller.pickDate(context),
                    child: const Text('Change date'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label:
                    controller.isEditing ? 'Save Changes' : 'Save Expense',
                onPressed: controller.save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

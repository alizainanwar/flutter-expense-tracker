/// A single expense entry.
class Expense {
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    String? category,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}

/// Expense categories used across the app.
class ExpenseCategories {
  static const List<String> all = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Other',
  ];
}

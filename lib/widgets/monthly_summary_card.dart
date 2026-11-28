import 'package:flutter/material.dart';

/// This month's totals per category, biggest first.
/// Shown on the home screen under the total spent card.
class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({super.key, required this.totals});

  final Map<String, double> totals;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (totals.isEmpty)
              const Text('No expenses this month yet.')
            else
              ...totals.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(entry.key),
                      const Spacer(),
                      Text(
                        'Rs ${entry.value.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

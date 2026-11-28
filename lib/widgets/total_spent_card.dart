import 'package:flutter/material.dart';

/// The "total spent" card shown at the top of the home screen.
class TotalSpentCard extends StatelessWidget {
  const TotalSpentCard({
    super.key,
    required this.totalSpent,
    required this.count,
  });

  final double totalSpent;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
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
              'Rs ${totalSpent.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$count expenses',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

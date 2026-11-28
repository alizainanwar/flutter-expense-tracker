import 'package:flutter/material.dart';

/// Reusable primary button used by every form in the app.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

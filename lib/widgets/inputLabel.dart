import 'package:flutter/material.dart';

class InputLabels extends StatelessWidget {
  final String label;
  const InputLabels({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(label,
          textAlign: TextAlign.left,
          style: TextStyle(
              letterSpacing: -0.41,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary)),
    );
  }
}

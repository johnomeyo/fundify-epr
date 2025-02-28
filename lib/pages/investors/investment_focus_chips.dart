import 'package:flutter/material.dart';

class InvestmentFocusChips extends StatelessWidget {
  const InvestmentFocusChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: const [
        Chip(label: Text("FinTech")),
        Chip(label: Text("Artificial Intelligence")),
        Chip(label: Text("HealthTech")),
        Chip(label: Text("SaaS")),
      ],
    );
  }
}

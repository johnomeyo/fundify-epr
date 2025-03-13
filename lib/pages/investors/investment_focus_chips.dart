import 'package:flutter/material.dart';

class InvestmentFocusChips extends StatelessWidget {
  final List<String> investmentFocus;

  const InvestmentFocusChips({
    super.key,
    required this.investmentFocus,
  });

  @override
  Widget build(BuildContext context) {
    if (investmentFocus.isEmpty) {
      return const Text(
        "No investment focus available",
        style: TextStyle(color: Colors.grey),
      );
    }

    return Wrap(
      spacing: 8,
      children: investmentFocus
          .map((focus) => Chip(label: Text(focus)))
          .toList(),
    );
  }
}

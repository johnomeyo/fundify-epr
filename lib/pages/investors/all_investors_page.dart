import 'package:flutter/material.dart';
import 'package:fundora/pages/homepage/header_text.dart';

class AllInvestorsPage extends StatelessWidget {
  const AllInvestorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderText()
        ],
      ),
    );
  }
}
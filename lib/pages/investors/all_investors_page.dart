import 'package:flutter/material.dart';
import 'package:fundora/pages/investors/search_widget.dart';

class AllInvestorsPage extends StatelessWidget {
  const AllInvestorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [SearchWidget()],
        ),
      ),
    );
  }
}

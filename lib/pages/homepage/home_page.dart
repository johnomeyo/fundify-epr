import 'package:flutter/material.dart';
import 'package:fundora/data.dart';
import 'package:fundora/pages/homepage/funding_opportunities_widget.dart';
import 'package:fundora/pages/homepage/header_text.dart';
// import 'package:fundora/pages/homepage/header_text.dart';
import 'package:fundora/pages/homepage/header_widget.dart';
import 'package:fundora/pages/homepage/insights.dart';
import 'package:fundora/pages/homepage/popular_investprs.dart';

class EntrepreneurHomePage extends StatelessWidget {
  const EntrepreneurHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover Investors",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeHeader(),
            const SizedBox(height: 24),
            const HeaderText(),
            const SizedBox(height: 16),
            PopularInvestors(investors: investors),
            const SizedBox(height: 24),
            EntrepreneurInsights(),
            FundingOpportunities()
          ],
        ),
      ),
    );
  }
}

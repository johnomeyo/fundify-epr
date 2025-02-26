import 'package:flutter/material.dart';
import 'package:fundora/data.dart';
import 'package:fundora/homepage/header_text.dart';
import 'package:fundora/homepage/header_widget.dart';
import 'package:fundora/homepage/popular_investprs.dart';

class EntrepreneurHomePage extends StatelessWidget {
  const EntrepreneurHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover Investors",
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(),
            HeaderText(),
            PopularInvestors(investors: investors),
          ],
        ),
      ),
    );
  }
}

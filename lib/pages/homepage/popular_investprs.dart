import 'package:flutter/material.dart';
import 'package:fundora/pages/homepage/investor_card.dart';

class PopularInvestors extends StatelessWidget {
  final List<Map<String, String>> investors;

  const PopularInvestors({
    super.key,
    required this.investors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: investors.length,
        itemBuilder: (context, index) {
          final investor = investors[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InvestorCard(
              name: investor['name']!,
              location: investor['location']!,
              imageUrl: investor['imageUrl']!,
            ),
          );
        },
      ),
    );
  }
}
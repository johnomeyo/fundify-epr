import 'package:flutter/material.dart';
import 'package:fundora/pages/investors/search_widget.dart';
import 'package:fundora/pages/homepage/investor_card.dart';
import 'package:fundora/data.dart';

class AllInvestorsPage extends StatelessWidget {
  const AllInvestorsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Investors"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchWidget(),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust for responsiveness
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7, // Adjust to fit InvestorCard properly
                ),
                itemCount: investors.length,
                itemBuilder: (context, index) {
                  final investor = investors[index];
                  return InvestorCard(
                    name: investor["name"]!,
                    location: investor["location"]!,
                    imageUrl: investor["imageUrl"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

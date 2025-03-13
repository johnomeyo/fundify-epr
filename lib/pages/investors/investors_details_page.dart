import 'package:flutter/material.dart';
import 'package:fundora/pages/investors/action_buttons.dart';
import 'package:fundora/pages/investors/contact_info.dart';
import 'package:fundora/pages/investors/investment_focus_chips.dart';
import 'package:fundora/pages/investors/investor_image.dart';

class InvestorDetailsPage extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;
  final String bio;
  final List<String> investmentFocus;
  final String contact;

  const InvestorDetailsPage({
    super.key,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.bio,
    required this.investmentFocus,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InvestorImage(imageUrl: imageUrl),
              InvestorInfo(name: name, bio: bio),
              SectionTitle(title: "Contact Information"),
              ContactInformation(
                contact: contact,
                isPremiumUser: false,
                location: location,
              ),
              SectionTitle(title: "About"),
              SectionContent(content: bio),
              SectionTitle(title: "Investment Focus"),
              InvestmentFocusChips(investmentFocus: investmentFocus),
              const SizedBox(height: 10),
              ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class InvestorInfo extends StatelessWidget {
  final String name;
  final String bio;
  const InvestorInfo({super.key, required this.name, required this.bio});

  String generateShortTitle(String bio) {
    List<String> keywords = [
      "AI",
      "FinTech",
      "SaaS",
      "HealthTech",
      "Startups",
      "Investor"
    ];
    for (String keyword in keywords) {
      if (bio.contains(keyword)) {
        return "Investor | $keyword";
      }
    }
    return "Investor";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(generateShortTitle(bio),
            style: const TextStyle(fontSize: 18, color: Colors.grey)),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;
  const SectionContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16),
    );
  }
}

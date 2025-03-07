import 'package:flutter/material.dart';
import 'package:fundora/pages/investors/action_buttons.dart';
import 'package:fundora/pages/investors/contact_info.dart';
import 'package:fundora/pages/investors/investment_focus_chips.dart';
import 'package:fundora/pages/investors/investor_image.dart';

class InvestorDetailsPage extends StatelessWidget {
  const InvestorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String bio =
        "Experienced investor with a passion for innovative startups in AI and fintech. Has backed over 20+ startups globally.";

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InvestorImage(),
              InvestorInfo(bio: bio),
              SectionTitle(title: "Contact Information"),
              ContactInformation(
                isPremiumUser: false,
              ),
              SectionTitle(title: "About"),
              SectionContent(
                content: bio,
              ),
              SectionTitle(title: "Investment Focus"),
              InvestmentFocusChips(),
              
              ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class InvestorInfo extends StatelessWidget {
  final String bio;
  const InvestorInfo({super.key, required this.bio});

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
        const Text(
          "John Doe",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          generateShortTitle(bio),
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
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

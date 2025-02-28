import 'package:flutter/material.dart';

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
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InvestorImage(),
            InvestorInfo(bio: bio),
            SectionTitle(title: "About"),
            SectionContent(
              content: bio,
            ),
            SectionTitle(title: "Investment Focus"),
            InvestmentFocusChips(),
            SectionTitle(title: "Contact Information"),
            ContactInformation(),
            ActionButtons(),
          ],
        ),
      ),
    );
  }
}

class InvestorImage extends StatelessWidget {
  const InvestorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1617727553252-65863c156eb0?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          fit: BoxFit.cover,
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

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.email),
          title: Text("johndoe@example.com"),
        ),
        ListTile(
          leading: Icon(Icons.link),
          title: Text("www.johndoeinvestments.com"),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("San Francisco, CA"),
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton.tonalIcon(
          onPressed: () {},
          icon: const Icon(Icons.message),
          label: const Text("Message"),
        ),
        FilledButton.tonalIcon(
          onPressed: () {},
          icon: const Icon(Icons.video_call),
          label: const Text("Schedule Call"),
        ),
      ],
    );
  }
}

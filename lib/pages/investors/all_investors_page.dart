import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundora/pages/homepage/investor_card.dart';

class AllInvestorsPage extends StatelessWidget {
  const AllInvestorsPage({super.key});

  Future<List<Map<String, dynamic>>> fetchInvestors() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('investors').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Investors")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchInvestors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No investors found."));
            }

            final investors = snapshot.data!;

            return ListView.builder(
              itemCount: investors.length,
              itemBuilder: (context, index) {
                final data = investors[index];

                return InvestorCard(
                  name: data["name"] ?? "Unknown",
                  location: data["location"] ?? "Unknown",
                  imageUrl: data["image"] ?? "",
                  bio: data["bio"] ?? "No bio available.",
                  investmentFocus:
                      List<String>.from(data["investmentFocus"] ?? []),
                  contact: data["email"] ?? "",
                );
              },
            );
          },
        ),
      ),
    );
  }
}

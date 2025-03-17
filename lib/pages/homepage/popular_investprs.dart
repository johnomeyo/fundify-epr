import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundora/pages/homepage/investor_card.dart';

class PopularInvestors extends StatelessWidget {
  const PopularInvestors({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('investors')
            .limit(5) // 🔹 Limit to top 5 investors
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No popular investors found."));
          }

          final investors = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: investors.length,
            itemBuilder: (context, index) {
              final data = investors[index].data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: InvestorCard(
                  name: data['name'] ?? 'Unknown',
                  location: data['location'] ?? 'Unknown',
                  imageUrl: data['image'] ?? '',
                  bio: data['bio'] ?? 'No bio available.', // 🔹 Added bio
                  investmentFocus: List<String>.from(data['investmentFocus'] ??
                      []), // 🔹 Added investmentFocus
                  contact: data['email'] ?? '', // 🔹 Added contact
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fundora/pages/profile%20page/profile_page_header.dart';
import 'package:fundora/pages/profile%20page/profile_picture.dart';
import 'package:fundora/pages/profile%20page/utilities_section.dart';
import 'package:fundora/pages/profile%20page/widget_helpers.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final ThemeData theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('startups').doc(userId).get(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // Handle error state
          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading profile: ${snapshot.error}'),
            );
          }
          
          // Handle empty data
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('No startup profile found. Please complete your profile setup.'),
            );
          }
          
          // Get the data
          final data = snapshot.data!.data() as Map<String, dynamic>;
          
          // Format monetary values
          final fundingGoal = _formatCurrency(data['fundingGoal'] ?? 0);
          final currentFunding = _formatCurrency(data['currentFunding'] ?? 0);
          final monthlyRevenue = _formatCurrency(data['monthlyRevenue'] ?? 0);
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                ProfilePicture(
                  name: data['companyName'] ?? 'Company Name',
                  industry: data['industry'] ?? 'Industry',
                  imageUrl: data['logo'] ?? '',
                ),
                
                const SizedBox(height: 16),
                const ProfilePageHeader(text: 'Details'),
                
                // Description Section
                CustomCard(
                  title: "Company",
                  children: [
                    TextSection(
                      title: "Description",
                      content: data['description'] ?? 'No description available',
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Key Metrics Section
                CustomCard(
                  title: "Key Metrics",
                  children: [
                    MetricItem(
                      label: "Funding Goal",
                      value: fundingGoal,
                      color: Colors.green,
                    ),
                    MetricItem(
                      label: "Current Funding",
                      value: currentFunding,
                      color: Colors.orange,
                    ),
                    MetricItem(
                      label: "Monthly Revenue",
                      value: monthlyRevenue,
                      color: Colors.blue,
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Problem and Solution Section
                CustomCard(
                  title: "Problem & Solution",
                  children: [
                    TextSection(
                      title: "Problem",
                      content: data['problem'] ?? 'No problem statement available',
                    ),
                    const SizedBox(height: 12),
                    TextSection(
                      title: "Solution",
                      content: data['solution'] ?? 'No solution statement available',
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Founder and Team Section - You might want to fetch this from a separate collection
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.secondary,
                      child: const Text(
                        "E",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    title:  Text(data['founder'] ?? 'Unkown Founder'),
                    subtitle: const Text("Founder"),
                  ),
                ),
                
                const SizedBox(height: 16),
                const ProfilePageHeader(text: 'Utilities'),
                const UtilitiesSection(),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // Helper method to format currency values
  String _formatCurrency(dynamic value) {
    if (value is double || value is int) {
      if (value >= 1000) {
        return '\$${(value / 1000).toStringAsFixed(0)}K';
      }
      return '\$${value.toStringAsFixed(0)}';
    }
    return '\$0';
  }
}
import 'package:flutter/material.dart';
import 'package:fundora/pages/profile%20page/profile_page_header.dart';
import 'package:fundora/pages/profile%20page/profile_picture.dart';
import 'package:fundora/pages/profile%20page/utilities_section.dart';
import 'package:fundora/pages/profile%20page/widget_helpers.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16, 
          children: [
            ProfilePicture(
              name: "Green Power Solutions",
              industry: "Renewable energy",
              imageUrl:
                  "https://images.unsplash.com/photo-1563694983011-6f4d90358083?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
            const ProfilePageHeader(
              text: 'Details',
            ),

            // Description Section
            CustomCard(
              title: "Description",
              children: [
                TextSection(
                  title: "Description",
                  content:
                      "Harnessing solar and wind energy for a sustainable future.",
                ),
              ],
            ),

            // Key Metrics Section
            CustomCard(
              title: "Key Metrics",
              children: [
                MetricItem(
                  label: "Funding Goal",
                  value: "\$300K",
                  color: Colors.green,
                ),
                MetricItem(
                  label: "Current Funding",
                  value: "\$100k",
                  color: Colors.orange,
                ),
                MetricItem(
                  label: "Monthly Revenue",
                  value: "\$2K",
                  color: Colors.blue,
                ),
              ],
            ),

            // Problem and Solution Section
            CustomCard(
              title: "Problem & Solution",
              children: [
                TextSection(
                  title: "Problem",
                  content:
                      "High costs and inefficiencies in renewable energy adoption.",
                ),
                const SizedBox(height: 12),
                TextSection(
                  title: "Solution",
                  content:
                      "We offer affordable solar and wind energy solutions.",
                ),
              ],
            ),

            // Founder and Team Section
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
                title: const Text("Emily Carter"),
                subtitle: const Text("Founder"),
              ),
            ),
            const ProfilePageHeader(
              text: 'Utilities',
            ),
            const UtilitiesSection(),
          ],
        ),
      ),
    );
  }
}

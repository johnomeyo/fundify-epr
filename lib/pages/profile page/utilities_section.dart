import 'package:flutter/material.dart';
import 'package:fundora/pages/profile%20page/faq_page.dart';
import 'package:fundora/pages/profile%20page/terms_of_service_page.dart';
import 'package:fundora/pages/profile%20page/utilities_tile.dart';
import 'package:fundora/services/auth_services.dart';

class UtilitiesSection extends StatelessWidget {
  const UtilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          UtilitiesTile(
              icon: Icons.info_outline,
              title: "Terms of Service",
              subtitle: "Check out how things work!",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsOfUsePage()));
              }),
          UtilitiesTile(
              icon: Icons.help_outline,
              title: "FAQ",
              subtitle: "Frequently Asked Questions",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FAQPage()));
              }),
          UtilitiesTile(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.red,
              subtitle: "Log out of your account",
              onTap: () {
                _showLogoutDialog(context);
              }),
        ],
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text(
            "Are you sure you want to logout? You can always log back in later."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              // Perform logout action here
              Navigator.of(context).pop(); // Close the dialog
              AuthServices().signOut();
              // Add your logout logic (e.g., clear session, navigate to login screen)
            },
            child: const Text("Logout"),
          ),
        ],
      );
    },
  );
}

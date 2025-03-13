import 'package:flutter/material.dart';
import 'dart:ui';

class ContactInformation extends StatelessWidget {
  final bool isPremiumUser; // Add a boolean to check if the user is premium
  final String location;
  const ContactInformation(
      {super.key,
      required this.isPremiumUser,
      required String contact,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email ListTile
        ListTile(
          leading: const Icon(Icons.email),
          title: Stack(
            children: [
              const Text("johndoe@example.com"),
              if (!isPremiumUser) // Apply blur if the user is not premium
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 5, sigmaY: 5), // Adjust blur intensity
                      child: Container(
                        color: Colors.transparent, // Transparent background
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Website ListTile
        ListTile(
          leading: const Icon(Icons.link),
          title: Stack(
            children: [
              const Text("www.johndoeinvestments.com"),
              if (!isPremiumUser) // Apply blur if the user is not premium
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 5, sigmaY: 5), // Adjust blur intensity
                      child: Container(
                        color: Colors.transparent, // Transparent background
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Location ListTile (no blur)
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text(location),
        ),
      ],
    );
  }
}

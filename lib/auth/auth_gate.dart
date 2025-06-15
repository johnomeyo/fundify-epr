import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fundora/auth/sign_in_page.dart';
import 'package:fundora/auth/profle_setup_page.dart';
import 'package:fundora/flow_loader_widget.dart';
import 'package:fundora/main.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _isInvestorProfileComplete(String userId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('startups')
          .doc(userId)
          .get();

      return docSnapshot.exists;
    } catch (e) {
      debugPrint('Error checking investor profile: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;

          // No signed-in user - go to sign-in page
          if (user == null) {
            return const SignInPage();
          }

          // User is signed in - check if they have an investor profile
          return FutureBuilder<bool>(
            future: _isInvestorProfileComplete(user.uid),
            builder: (context, investorSnapshot) {
              if (investorSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  // body: Center(child: CircularProgressIndicator()),
                  body: FlowLoader(
                    size: 120,
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              // User exists in investors collection - go to home
              if (investorSnapshot.data == true) {
                return const HomeScreen();
              }

              // User doesn't have a profile yet - go to profile setup
              return const ProfileSetupPage();
            },
          );
        }

        // Connection state not yet active - show loading
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

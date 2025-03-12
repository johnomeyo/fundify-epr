import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fundora/auth/sign_in_page.dart';
import 'package:fundora/auth/profle_setup_page.dart';
import 'package:fundora/main.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _isFirstTimeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTimeUser') ?? true;
  }

  Future<void> _setFirstTimeUserFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTimeUser', false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user != null) {
            return FutureBuilder<bool>(
              future: _isFirstTimeUser(),
              builder: (context, firstTimeSnapshot) {
                if (firstTimeSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                if (firstTimeSnapshot.data == true) {
                  _setFirstTimeUserFlag(); // Mark as not first time
                  return const ProfileSetupPage();
                }
                return const HomeScreen();
              },
            );
          }
          return const SignInPage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

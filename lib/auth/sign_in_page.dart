import 'package:flutter/material.dart';
import 'package:fundora/services/auth_services.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo / Branding
              CircleAvatar(
                radius: 80,
                backgroundColor:
                    Colors.grey.shade200, // Optional background color
                foregroundImage:
                    AssetImage("assets/logo2.jpeg"), // Uses image directly
              ),
              const SizedBox(height: 24),

              // Headline
              const Text(
                "Welcome to Flow",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtext
              const Text(
                "Connect with investors and entrepreneurs to fund great ideas and grow businesses.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Google Sign-In Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    // //Add Google Sign-In Logic
                    await AuthServices().signInWithGoogle();
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(builder: (ctx) => ProfileSetupPage()),
                    //     (route) => false);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // icon: Image.asset(
                  //   'assets/google_logo.png', // Ensure you have a Google logo asset
                  //   height: 24,
                  //   width: 24,
                  // ),
                  child: const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

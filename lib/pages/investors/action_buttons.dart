import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton.tonalIcon(
          onPressed: () => _showPremiumDialog(context, "message"),
          icon: const Icon(Icons.message),
          label: const Text("Message"),
        ),
        FilledButton.tonalIcon(
          onPressed: () => _showPremiumDialog(context, "schedule calls"),
          icon: const Icon(Icons.video_call),
          label: const Text("Schedule Call"),
        ),
      ],
    );
  }

  void _showPremiumDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Premium Feature'),
          content: Text(
            'Only premium users can $feature with investors. '
            'Upgrade to premium for \$9.99 per month to unlock this feature.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Dismiss'),
            ),
            FilledButton(
              onPressed: () {
                // Add your upgrade logic here
                Navigator.of(context).pop();
                _handleUpgrade(context);
              },
              child: const Text('Upgrade to Premium'),
            ),
          ],
        );
      },
    );
  }

  void _handleUpgrade(BuildContext context) {
    // Implement your payment processing logic here
    // This is where you'd connect to your payment gateway

    // For demonstration, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Redirecting to payment gateway...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

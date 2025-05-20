import 'package:flutter/material.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade to Flow Premium'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.lock_open_rounded, size: 80, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Unlock Your Startup’s Full Potential',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Investors can message you even on the free plan — and you can reply. But with Premium, you take the lead.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            _buildFeatureTile("✅ Message investors first"),
            _buildFeatureTile("✅ See who's viewed your profile"),
            _buildFeatureTile("✅ Priority placement in discovery"),
            _buildFeatureTile("✅ Apply to exclusive pitch events"),
            _buildFeatureTile("✅ Profile insights & analytics"),
            _buildFeatureTile("✅ Early access to new features"),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Trigger subscription flow here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Upgrade to Premium',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Maybe later"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

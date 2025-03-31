import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to adapt to available width
    return LayoutBuilder(
      builder: (context, constraints) {
        // For very narrow screens, stack buttons vertically
        if (constraints.maxWidth < 280) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildButton(
                context: context,
                icon: Icons.message,
                label: "Message",
                feature: "message",
                isFullWidth: true,
              ),
              const SizedBox(height: 12),
              _buildButton(
                context: context,
                icon: Icons.video_call,
                label: "Schedule Call",
                feature: "schedule calls",
                isFullWidth: true,
              ),
            ],
          );
        }
        
        // For normal screens, use row layout with flexible width
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildButton(
                context: context,
                icon: Icons.message,
                label: "Message",
                feature: "message",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildButton(
                context: context,
                icon: Icons.video_call,
                label: "Schedule Call",
                feature: "schedule calls",
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String feature,
    bool isFullWidth = false,
  }) {
    return FilledButton.tonalIcon(
      onPressed: () => _showPremiumDialog(context, feature),
      icon: Icon(icon),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      style: ButtonStyle(
        minimumSize: isFullWidth
            ? WidgetStateProperty.all<Size>(const Size(double.infinity, 40))
            : null,
      ),
    );
  }

  void _showPremiumDialog(BuildContext context, String feature) {
    // Get the available screen size to ensure dialog fits
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 350;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Premium Feature',
            style: TextStyle(
              fontSize: isSmallScreen ? 18 : 20,
            ),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenSize.width * 0.8,
              maxHeight: screenSize.height * 0.3,
            ),
            child: SingleChildScrollView(
              child: Text(
                'Only premium users can $feature with investors. '
                'Upgrade to premium for \$9.99 per month to unlock this feature.',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ),
          ),
          actions: isSmallScreen
              ? [
                  // Vertical layout for small screens
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                        onPressed: () {
                          // Add your upgrade logic here
                          Navigator.of(context).pop();
                          _handleUpgrade(context);
                        },
                        child: const Text('Upgrade to Premium'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Dismiss'),
                      ),
                    ],
                  ),
                ]
              : [
                  // Horizontal layout for normal screens
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dismiss'),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      // Add your upgrade logic here
                      Navigator.of(context).pop();
                      _handleUpgrade(context);
                    },
                    child: const Text('Upgrade to Premium'),
                  ),
                ],
          actionsPadding: const EdgeInsets.all(12),
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
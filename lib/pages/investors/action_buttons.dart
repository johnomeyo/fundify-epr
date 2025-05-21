import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundora/pages/chat/chat_page.dart';
import 'package:fundora/pages/payment_wall/paywall_page.dart' show PaywallPage;
import 'package:url_launcher/url_launcher.dart' show launchUrl;
import 'package:url_launcher/url_launcher_string.dart' show LaunchMode;

class ActionButtons extends StatelessWidget {
  final String investorName;
  final String investorID;
  final bool isPremium;
  const ActionButtons(
      {super.key,
      required this.investorName,
      required this.investorID,
      required this.isPremium});

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
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(
                              otherUserName: investorName,
                              otherUserId: investorID,
                            )),
                  );
                },
                icon: const Icon(Icons.email, size: 16),
                label: const Text("Contact"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ),
              ),
              const SizedBox(height: 12),
              _buildButton(
                context: context,
                icon: Icons.video_call,
                label: "Schedule Call",
                feature: "schedule calls",
                isFullWidth: true,
                isPremium: isPremium,
              ),
            ],
          );
        }

        // For normal screens, use row layout with flexible width
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: isPremium
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    otherUserName: investorName,
                                    otherUserId: investorID,
                                  )),
                        );
                      }
                    : () {
                        _showPremiumDialog(context, "contact investors");
                      },
                // onPressed: () {
                icon: const Icon(Icons.email, size: 16),
                label: const Text("Contact"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildButton(
                isPremium: isPremium,
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
    required bool isPremium,
    bool isFullWidth = false,
    bool isGoogleMeet = true,
  }) {
    return FilledButton.icon(
      onPressed: isPremium
          ? () {
              if (isGoogleMeet) {
                _launchGoogleMeet(context);
              } else {
                _showPremiumDialog(context, feature);
              }
            }
          : () {
              _showPremiumDialog(context, feature);
            },
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

  void _launchGoogleMeet(BuildContext context) async {
    const String googleMeetUrl = 'https://meet.google.com/new';

    try {
      // Try to launch using url_launcher with specific mode settings
      final Uri url = Uri.parse(googleMeetUrl);
      if (!await launchUrl(
        url,
        mode: LaunchMode
            .externalApplication, // Forces opening in external browser
      )) {
        // If that fails, show a dialog with the URL
        if (context.mounted) {
          _showUrlDialog(context, googleMeetUrl);
        }
      }
    } catch (e) {
      debugPrint('Error launching Google Meet: $e');
      // Show a dialog with the URL
      if (context.mounted) {
        _showUrlDialog(context, googleMeetUrl);
      }
    }
  }

  void _showUrlDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Open Google Meet'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Unable to open automatically. Copy this link and open in your browser:'),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: url));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link copied to clipboard')),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        url,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Icon(Icons.copy, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
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
                'View Details to unlock this feature.',
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
                        child: const Text('View Details'),
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
                  FilledButton(
                    onPressed: () {
                      // Add your upgrade logic here
                      Navigator.of(context).pop();
                      _handleUpgrade(context);
                    },
                    child: const Text('View Details'),
                  ),
                ],
          actionsPadding: const EdgeInsets.all(12),
        );
      },
    );
  }

  void _handleUpgrade(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaywallPage(),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:fundora/pages/investors/action_buttons.dart';
import 'package:fundora/pages/investors/contact_info.dart';
import 'package:fundora/pages/investors/investment_focus_chips.dart';
import 'package:fundora/pages/investors/investor_image.dart';

class InvestorDetailsPage extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;
  final String bio;
  final List<String> investmentFocus;
  final String contact;

  const InvestorDetailsPage({
    super.key,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.bio,
    required this.investmentFocus,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero section with image and gradient overlay with border radius
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.8),
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: InvestorImage(imageUrl: imageUrl),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 8),
                              _buildLocationChip(location),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Investment Focus - Now using the minimalist card design
              _buildMinimalistCard(
                context: context,
                title: "Investment Focus",
                icon: Icons.trending_up,
                customContent:
                    InvestmentFocusChips(investmentFocus: investmentFocus),
              ),

              // About section - Minimalist card design
              _buildMinimalistCard(
                context: context,
                title: "About",
                icon: Icons.person_outline,
                content: bio,
              ),

              // Contact section - Clean minimalist design
              _buildMinimalistCard(
                context: context,
                title: "Contact Information",
                icon: Icons.contact_mail_outlined,
                customContent: ContactInformation(
                  contact: contact,
                  isPremiumUser: false,
                  location: location,
                ),
              ),

              // Action buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: ActionButtons(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationChip(String location) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              location,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalistCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    String? content,
    Widget? customContent,
    bool showDivider = false,
    List<Widget>? metrics,
    bool bulletPoints = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (customContent != null)
            customContent
          else if (content != null && bulletPoints)
            _buildBulletPoints(context, content)
          else if (content != null)
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              softWrap: true,
            ),
          if (showDivider) ...[
            const SizedBox(height: 16),
            Divider(color: Theme.of(context).dividerColor.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            metrics != null
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      return constraints.maxWidth < 300
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: metrics,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: metrics,
                            );
                    },
                  )
                : const SizedBox.shrink(),
          ],
        ],
      ),
    );
  }

  Widget _buildBulletPoints(BuildContext context, String content) {
    List<String> points = content.split('|');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points
          .map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "•  ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        point.trim(),
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.8),
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
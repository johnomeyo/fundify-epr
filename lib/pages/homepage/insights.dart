import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EntrepreneurInsights extends StatelessWidget {
  const EntrepreneurInsights({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Startup Insights",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("View All"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildInsightCards(context),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildInsightCards(BuildContext context) {
    final theme = Theme.of(context);

    // List of insight data with URLs
    final insights = [
      {
        'title': 'How to Perfect Your Pitch Deck',
        'category': 'Fundraising',
        'readTime': '10 min read',
        'icon': Icons.slideshow,
        'url': 'https://www.youtube.com/watch?v=SB16xgtFmco',
      },
      {
        'title': 'Financial Projections That Impress Investors',
        'category': 'Finance',
        'readTime': '7 min read',
        'icon': Icons.bar_chart,
        'url': 'https://www.indeed.com/career-advice/career-development/financial-projection-startup',
      },
      {
        'title': 'Top Industries Attracting VC Funding in 2025',
        'category': 'Market Trends',
        'readTime': '4 min read',
        'icon': Icons.trending_up,
        'url': 'https://eqvista.com/industries-sectors-received-vc-funding/',
      },
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: insights.length,
      itemBuilder: (context, index) {
        final insight = insights[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: InkWell(
            onTap: () => _launchUrl(insight['url'] as String),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha:0.2),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                // Adjust icon container size based on available width
                final isSmallScreen = constraints.maxWidth < 300;
                final iconSize = isSmallScreen ? 60.0 : 80.0;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: iconSize,
                      height: iconSize,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Icon(
                        insight['icon'] as IconData,
                        size: isSmallScreen ? 24 : 32,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(isSmallScreen ? 8.0 : 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              insight['title'] as String,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    insight['category'] as String,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 12,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha:0.6),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      insight['readTime'] as String,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha:0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

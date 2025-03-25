import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StartupInsightsPage extends StatelessWidget {
  const StartupInsightsPage({super.key});

  // Centralized URL launcher method
  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Startup Insights',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Insights Section
            _buildTrendingInsightsSection(context),

            // Curated Resources Section
            _buildCuratedResourcesSection(context),

            // Industry Deep Dive Section
            _buildIndustryDeepDiveSection(context),

            // Startup Success Stories Section
            _buildStartupSuccessStoriesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingInsightsSection(BuildContext context) {
    final theme = Theme.of(context);
    final trendingInsights = [
      {
        'title': 'How to Perfect Your Pitch Deck',
        'description':
            'Master the art of creating compelling investor presentations',
        'icon': Icons.slideshow,
        'url': 'https://www.youtube.com/watch?v=SB16xgtFmco',
        'color': Colors.blue,
      },
      {
        'title': 'Financial Projections That Wow',
        'description': 'Create financial models that attract serious investors',
        'icon': Icons.bar_chart,
        'url':
            'https://www.indeed.com/career-advice/career-development/financial-projection-startup',
        'color': Colors.green,
      },
      {
        'title': 'VC Funding Trends 2025',
        'description': 'Emerging industries and investment opportunities',
        'icon': Icons.trending_up,
        'url': 'https://eqvista.com/industries-sectors-received-vc-funding/',
        'color': Colors.purple,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Insights',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: trendingInsights.map((insight) {
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: GestureDetector(
                  onTap: () => _launchUrl(context, insight['url'] as String),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (insight['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            (insight['color'] as Color).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: (insight['color'] as Color),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            insight['icon'] as IconData,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          insight['title'] as String,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          insight['description'] as String,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCuratedResourcesSection(BuildContext context) {
    final theme = Theme.of(context);
    final resources = [
      {
        'title': 'Startup Funding Guide',
        'subtitle': 'Comprehensive fundraising strategies',
        'icon': Icons.attach_money,
        'url': 'https://example.com/startup-funding-guide',
      },
      {
        'title': 'Market Research Toolkit',
        'subtitle': 'Tools for startup market analysis',
        'icon': Icons.analytics,
        'url': 'https://example.com/market-research-toolkit',
      },
      {
        'title': 'Startup Legal Checklist',
        'subtitle': 'Essential legal considerations',
        'icon': Icons.gavel,
        'url': 'https://example.com/startup-legal-checklist',
      },
    ];

    return Container(
      color: theme.colorScheme.surfaceContainerLowest,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Curated Resources',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: resources.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final resource = resources[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    resource['icon'] as IconData,
                    color: theme.colorScheme.primary,
                  ),
                ),
                title: Text(
                  resource['title'] as String,
                  style: theme.textTheme.titleMedium,
                ),
                subtitle: Text(
                  resource['subtitle'] as String,
                  style: theme.textTheme.bodySmall,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: theme.colorScheme.primary,
                  size: 16,
                ),
                onTap: () => _launchUrl(context, resource['url'] as String),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIndustryDeepDiveSection(BuildContext context) {
    final theme = Theme.of(context);
    final industries = [
      {
        'name': 'AI & Machine Learning',
        'description': 'Emerging technologies reshaping industries',
        'progress': 0.8,
        'color': Colors.deepPurple,
        'insight':
            'AI and machine learning automate tasks, analyze data, and improve decision-making. Startups can leverage them for chatbots, personalization, and predictive analytics. Key trends include generative AI, automation, and AI-driven insights. Challenges include data privacy, bias, and high computational costs. Success depends on strong data, ethical AI, and scalable models.'
      },
      {
        'name': 'Green Tech',
        'description': 'Sustainable solutions for global challenges',
        'progress': 0.6,
        'color': Colors.green,
        'insight':
            'Green tech focuses on sustainable solutions like renewable energy, waste reduction, and eco-friendly products. Startups can innovate in solar, electric mobility, and carbon capture. Key trends include energy efficiency, circular economy, and climate-focused AI. Challenges include high costs, regulatory hurdles, and scalability. Success depends on innovation, policy support, and market adoption.'
      },
      {
        'name': 'Fintech',
        'description': 'Revolutionizing financial services',
        'progress': 0.7,
        'color': Colors.blue,
        'insight':
            'Fintech uses technology to improve payments, lending, and banking. Startups succeed by solving real financial problems, ensuring compliance, and offering seamless user experiences. Key trends include AI finance, DeFi, and mobile banking. Challenges include security, competition, and trust. Growth relies on partnerships, mobile-first design, and viral marketing.'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Industry Deep Dive',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...industries.map((industry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (industry['color'] as Color).withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      industry['name'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      industry['description'] as String,
                      style: theme.textTheme.bodySmall,
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: LinearProgressIndicator(
                        value: industry['progress'] as double,
                        backgroundColor:
                            (industry['color'] as Color).withValues(alpha: 0.2),
                        color: industry['color'] as Color,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '${industry['insight']}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStartupSuccessStoriesSection(BuildContext context) {
    final theme = Theme.of(context);
    final stories = [
      {
        'title': 'From Garage to Unicorn',
        'startup': 'Lumis Softwares',
        'description': 'How SaaS solved a global challenge',
        'imageUrl':
            'https://lumissoftware.co.ke/static/media/logo.746ece76553898063c47.png',
        'url': 'https://lumissoftware.co.ke/',
      },
      {
        'title': 'Sustainable Innovation Wins',
        'startup': 'BonTon ',
        'description': 'Transforming renewable energy landscape',
        'imageUrl':
            'https://images.unsplash.com/photo-1602934445884-da0fa1c9d3b3?q=80&w=2158&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'url': 'https://lumissoftware.co.ke/',
      },
    ];

    return Container(
      color: theme.colorScheme.surfaceContainerLowest,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Startup Success Stories',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: stories.map((story) {
                return GestureDetector(
                  onTap: () => _launchUrl(context, story['url'] as String),
                  child: Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            story['imageUrl'] as String,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story['title'] as String,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                story['startup'] as String,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                story['description'] as String,
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

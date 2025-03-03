import 'package:flutter/material.dart';

class FundingOpportunities extends StatelessWidget {
  const FundingOpportunities({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Funding Opportunities",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Explore All"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildOpportunityCards(context),
      ],
    );
  }

  Widget _buildOpportunityCards(BuildContext context) {
    final theme = Theme.of(context);
    
    // Example funding data
    final opportunities = [
      {
        'title': 'Tech Innovation Grant',
        'range': '\$10K - \$50K',
        'deadline': 'Mar 20, 2025',
        'tags': ['Tech', 'Early Stage'],
        'color': Colors.blue,
      },
      {
        'title': 'Social Impact Accelerator',
        'range': '\$25K - \$100K',
        'deadline': 'Apr 5, 2025',
        'tags': ['Social', 'Seed'],
        'color': Colors.green,
      },
    ];

    return SizedBox(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: opportunities.length,
        itemBuilder: (context, index) {
          final opportunity = opportunities[index];
          final color = opportunity['color'] as Color;
          
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.7),
                  color,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background decorative elements
                Positioned(
                  bottom: -20,
                  right: -20,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                Positioned(
                  top: -15,
                  left: -15,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                
                // Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fund icon
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.attach_money,
                              color: color,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          
                          // Fund details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  opportunity['title'] as String,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  opportunity['range'] as String,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Tags row
                      Wrap(
                        spacing: 8,
                        children: (opportunity['tags'] as List).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tag,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Deadline
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Deadline: ${opportunity['deadline']}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
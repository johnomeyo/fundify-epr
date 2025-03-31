import 'package:flutter/material.dart';
import 'package:fundora/pages/homepage/header_text.dart';
import 'package:fundora/pages/homepage/header_widget.dart';
import 'package:fundora/pages/homepage/insights.dart';
import 'package:fundora/pages/homepage/popular_investprs.dart';

class EntrepreneurHomePage extends StatelessWidget {
  const EntrepreneurHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover Investors",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        //actions: [
        // IconButton(
        //   icon: const Icon(Icons.notifications_outlined),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: const Icon(Icons.person_outline),
        //   onPressed: () {},
        // ),
        //]
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeHeader(),
            const SizedBox(height: 24),
            const HeaderText(),
            const SizedBox(height: 16),
            PopularInvestors(),
            const SizedBox(height: 24),
            EntrepreneurInsights(),
            const SizedBox(height: 24),
            // _buildOpportunitySection(context),
            // const SizedBox(height: 24),
            // _buildMentorshipSection(context),
            // const SizedBox(height: 24),
            // _buildNetworkingEventsSection(context),
            // const SizedBox(height: 24),
            // _buildStartupHealthSection(context),
          ],
        ),
      ),
    );
  }

//   // Opportunity Matching Section
//   Widget _buildOpportunitySection(BuildContext context) {
//     return _buildHomeSection(
//       context,
//       icon: Icons.rocket_launch_outlined,
//       title: 'Investment Opportunities',
//       description:
//           'Discover curated investment opportunities tailored to your interests.',
//       onTap: () {
//         // Navigate to opportunities page
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => InvestmentOpportunitiesPage()));
//       },
//     );
//   }

//   // Mentorship Section
//   Widget _buildMentorshipSection(BuildContext context) {
//     return _buildHomeSection(
//       context,
//       icon: Icons.supervised_user_circle_outlined,
//       title: 'Mentorship Connect',
//       description:
//           'Find and connect with experienced mentors in your industry.',
//       onTap: () {
//         // Navigate to mentorship page
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => MentorshipConnectPage()));
//       },
//     );
//   }

//   // Networking Events Section
//   Widget _buildNetworkingEventsSection(BuildContext context) {
//     return _buildHomeSection(
//       context,
//       icon: Icons.event_outlined,
//       title: 'Networking Events',
//       description: 'Join upcoming investor and entrepreneur networking events.',
//       onTap: () {
//         // Navigate to events page
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => NetworkingEventsPage()));
//       },
//     );
//   }

//   // Startup Health Section
//   Widget _buildStartupHealthSection(BuildContext context) {
//     return _buildHomeSection(
//       context,
//       icon: Icons.dashboard_outlined,
//       title: 'Startup Health Tracker',
//       description:
//           'Monitor and improve key metrics for your startup\'s growth.',
//       onTap: () {
//         // Navigate to startup health page
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => StartupHealthTrackerPage()));
//       },
//     );
//   }

//   // Generic section builder with consistent styling
//   Widget _buildHomeSection(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String description,
//     required VoidCallback onTap,
//   }) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: theme.colorScheme.surface,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: theme.colorScheme.shadow.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.primaryContainer.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 icon,
//                 color: theme.colorScheme.primary,
//                 size: 28,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     description,
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: theme.colorScheme.onSurface.withOpacity(0.7),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.chevron_right,
//               color: theme.colorScheme.primary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}

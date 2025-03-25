import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 1. Investment Opportunities Page
class InvestmentOpportunitiesPage extends StatefulWidget {
  const InvestmentOpportunitiesPage({Key? key}) : super(key: key);

  @override
  _InvestmentOpportunitiesPageState createState() => _InvestmentOpportunitiesPageState();
}

class _InvestmentOpportunitiesPageState extends State<InvestmentOpportunitiesPage> {
  final List<String> _industries = [
    'Tech', 'FinTech', 'Healthcare', 'AI', 'Blockchain', 'CleanTech'
  ];
  String _selectedIndustry = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investment Opportunities', 
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Industry Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _industries.map((industry) => 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(industry),
                    selected: _selectedIndustry == industry,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedIndustry = selected ? industry : '';
                      });
                    },
                  ),
                )
              ).toList(),
            ),
          ),
          
          // Opportunities List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection('investment_opportunities')
                .where(_selectedIndustry.isNotEmpty 
                  ? 'industry' : 'published', 
                  isEqualTo: _selectedIndustry.isNotEmpty 
                    ? _selectedIndustry 
                    : true)
                .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final opportunities = snapshot.data!.docs;
                
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: opportunities.length,
                  itemBuilder: (context, index) {
                    final opportunity = opportunities[index].data() as Map<String, dynamic>;
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        title: Text(
                          opportunity['title'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(opportunity['industry']),
                            Text('\$${opportunity['funding_goal']} Seeking'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Show detailed opportunity modal
                            _showOpportunityDetails(context, opportunity);
                          },
                          child: const Text('Details'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showOpportunityDetails(BuildContext context, Map<String, dynamic> opportunity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            children: [
              // Opportunity details here
            ],
          ),
        ),
      ),
    );
  }
}

// 2. Mentorship Connect Page
class MentorshipConnectPage extends StatefulWidget {
  const MentorshipConnectPage({Key? key}) : super(key: key);

  @override
  _MentorshipConnectPageState createState() => _MentorshipConnectPageState();
}

class _MentorshipConnectPageState extends State<MentorshipConnectPage> {
  final List<String> _expertiseAreas = [
    'Startup Strategy', 'Fundraising', 'Product Development', 
    'Marketing', 'Tech Leadership'
  ];
  String _selectedExpertise = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentorship Connect', 
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Expertise Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _expertiseAreas.map((area) => 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(area),
                    selected: _selectedExpertise == area,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedExpertise = selected ? area : '';
                      });
                    },
                  ),
                )
              ).toList(),
            ),
          ),
          
          // Mentors List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection('mentors')
                .where(_selectedExpertise.isNotEmpty 
                  ? 'expertise' : 'active', 
                  isEqualTo: _selectedExpertise.isNotEmpty 
                    ? _selectedExpertise 
                    : true)
                .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final mentors = snapshot.data!.docs;
                
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: mentors.length,
                  itemBuilder: (context, index) {
                    final mentor = mentors[index].data() as Map<String, dynamic>;
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(mentor['profile_pic']),
                        ),
                        title: Text(
                          mentor['name'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(mentor['expertise']),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Request mentorship
                            _requestMentorship(mentor);
                          },
                          child: const Text('Connect'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _requestMentorship(Map<String, dynamic> mentor) {
    // Implement mentorship request logic
  }
}

// 3. Networking Events Page
class NetworkingEventsPage extends StatefulWidget {
  const NetworkingEventsPage({Key? key}) : super(key: key);

  @override
  _NetworkingEventsPageState createState() => _NetworkingEventsPageState();
}

class _NetworkingEventsPageState extends State<NetworkingEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Networking Events', 
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
          .collection('networking_events')
          .where('date', isGreaterThan: DateTime.now())
          .orderBy('date')
          .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final events = snapshot.data!.docs;
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;
              
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(
                    event['title'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event['location']),
                      Text(event['date'].toDate().toString()),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Register for event
                      _registerForEvent(event);
                    },
                    child: const Text('Register'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _registerForEvent(Map<String, dynamic> event) {
    // Implement event registration logic
  }
}

// 4. Startup Health Tracker Page
class StartupHealthTrackerPage extends StatefulWidget {
  const StartupHealthTrackerPage({Key? key}) : super(key: key);

  @override
  _StartupHealthTrackerPageState createState() => _StartupHealthTrackerPageState();
}

class _StartupHealthTrackerPageState extends State<StartupHealthTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Health Tracker', 
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
          .collection('startups')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final startupData = snapshot.data!.data() as Map<String, dynamic>;
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Key Metrics Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key Metrics',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildMetricTile('Monthly Revenue', 
                        startupData['monthly_revenue'].toString()),
                      _buildMetricTile('Burn Rate', 
                        startupData['burn_rate'].toString()),
                      _buildMetricTile('Customer Acquisition Cost', 
                        startupData['customer_acquisition_cost'].toString()),
                    ],
                  ),
                ),
              ),
              
              // Growth Projections
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Growth Projections',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Add growth projection visualization
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add/Edit startup metrics
          _showMetricsUpdateDialog(context);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildMetricTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showMetricsUpdateDialog(BuildContext context) {
    // Implement metrics update dialog
  }
}
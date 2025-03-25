import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms of Use"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, "Welcome to Flow"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "By accessing Flow, you agree to comply with our Terms of Use. "
              "Flow is a platform connecting entrepreneurs and investors. We do not provide financial, legal, or investment advice.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Investor Responsibilities"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. Investors acknowledge that all investments involve financial risk and potential loss.\n"
              "2. Flow does not conduct background checks on startups; investors must conduct independent due diligence.\n"
              "3. Investors agree not to engage in fraudulent activities, false advertising, or misleading entrepreneurs.\n"
              "4. Flow does not provide guarantees regarding the profitability or success of any startup.\n"
              "5. Investment transactions must comply with local regulations and tax laws.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Entrepreneur Responsibilities"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. Entrepreneurs must provide accurate, complete, and honest information about their startups.\n"
              "2. Misrepresentation, fraudulent claims, or false financial projections will result in immediate account termination.\n"
              "3. Entrepreneurs must comply with all local business and investment laws when seeking funding.\n"
              "4. Flow reserves the right to review and remove any pitch that violates our policies.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Investment Risk Disclaimer"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "Investing in startups carries inherent risks, including potential loss of investment. Flow is not responsible "
              "for any financial losses or disputes arising from user transactions. We do not offer refunds, financial guarantees, or mediation services.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Privacy & Data Protection"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. Flow collects user data to enhance platform functionality. We do not sell personal data to third parties.\n"
              "2. User profiles, pitches, and investment details may be visible to other users as per privacy settings.\n"
              "3. Users have the right to request data removal, except for information required by law for compliance.\n"
              "4. We implement security measures to protect data but cannot guarantee absolute protection from cyber threats.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Platform Limitations"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. Flow acts as a connection platform and does not facilitate financial transactions between users.\n"
              "2. We are not responsible for agreements made outside our platform.\n"
              "3. The availability of services may vary based on location and regulatory restrictions.\n"
              "4. Flow reserves the right to update policies, features, and services without prior notice.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Dispute Resolution"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. Flow does not mediate financial disputes between investors and entrepreneurs.\n"
              "2. Any disagreements must be resolved independently or through appropriate legal channels.\n"
              "3. Users may report fraudulent activities, and Flow reserves the right to investigate and take appropriate action.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Account Suspension & Termination"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. Flow reserves the right to suspend or terminate accounts involved in fraud, illegal activities, or policy violations.\n"
              "2. Users found engaging in scams, fake investments, or misleading behavior will be permanently banned.\n"
              "3. Suspended users may appeal decisions, but Flow holds final authority on account reinstatement.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Legal Compliance"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "Users are responsible for ensuring compliance with their country's laws regarding investments, business operations, and data protection. "
              "Flow does not provide legal consultation.",
            ),
            const SizedBox(height: 20),

            _buildSectionHeader(context, "Updates to Terms"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "Flow may update these terms periodically. Continued use of the platform constitutes acceptance of changes. "
              "We will notify users of major updates through email or in-app notifications.",
            ),
            const SizedBox(height: 8),

            // Last Updated Text
            const Center(
              child: Text(
                "Last updated: February 2025",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    final theme = Theme.of(context);
    return Text(
      content,
      style: theme.textTheme.bodyMedium?.copyWith(
        height: 1.5,
        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
      ),
    );
  }
}
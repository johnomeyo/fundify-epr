import 'package:flutter/material.dart';

class ProfilePageHeader extends StatelessWidget {
  final String text;
  const ProfilePageHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style:
            theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

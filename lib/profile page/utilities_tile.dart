import 'package:flutter/material.dart';

class UtilitiesTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? color;

  const UtilitiesTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color:color ?? colorScheme.primary),
      title: Text(title, style: TextStyle(color:color?? colorScheme.primary.withValues(alpha: 0.5))),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
      onTap: onTap,
    );
  }
}
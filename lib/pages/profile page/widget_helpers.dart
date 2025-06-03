// custom_widgets.dart
import 'package:flutter/material.dart';

/// A reusable widget for displaying a metric item with an icon.
class MetricItem extends StatelessWidget {
  final String label;
  final String? value;
  final Color color;

  const MetricItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Text(
                  "$label: ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value?.isNotEmpty == true ? value! : "N/A",
                  style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A reusable widget for displaying a text section with a title and content.
class TextSection extends StatelessWidget {
  final String title;
  final String? content;

  const TextSection({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          content?.isNotEmpty == true ? content! : "N/A",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

/// A reusable widget for displaying a card with a title and a list of children.
class CustomCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const CustomCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              ...children.map(
                (child) => child is Row
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: child,
                      )
                    : child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

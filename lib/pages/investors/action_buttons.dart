
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton.tonalIcon(
          onPressed: () {},
          icon: const Icon(Icons.message),
          label: const Text("Message"),
        ),
        FilledButton.tonalIcon(
          onPressed: () {},
          icon: const Icon(Icons.video_call),
          label: const Text("Schedule Call"),
        ),
      ],
    );
  }
}

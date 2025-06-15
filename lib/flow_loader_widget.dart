import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FlowLoader extends StatelessWidget {
  final double size;
  final Color? backgroundColor;

  const FlowLoader({super.key, this.size = 120, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/flow_loader.json',
        width: size,
        height: size,
        repeat: true,
      ),
    );
  }
}

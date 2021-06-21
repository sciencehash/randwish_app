import 'package:flutter/material.dart';

class IconGradientMask extends StatelessWidget {
  final Widget child;

  IconGradientMask({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff4f72e6), Color(0xff7a5ee8)],
      ).createShader(bounds),
      child: child,
    );
  }
}

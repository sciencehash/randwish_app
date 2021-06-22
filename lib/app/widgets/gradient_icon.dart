import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData iconData;
  final double size;

  GradientIcon({Key? key, required this.iconData, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff4f72e6),
          Color(0xff7a5ee8),
        ],
      ).createShader(bounds),
      child: Icon(
        iconData,
        size: size,
        color: Colors.white,
      ),
    );
  }
}

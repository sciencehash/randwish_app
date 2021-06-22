import 'package:flutter/material.dart';
import 'package:randwish_app/app/widgets/gradient_icon.dart';

class SliverEmptyListView extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subtitle;

  const SliverEmptyListView({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientIcon(
              iconData: iconData,
              size: 37,
            ),
            SizedBox(height: 32),
            Text(
              title,
              style: TextStyle(
                fontSize: 19,
                color: Color(0xFF363636),
              ),
            ),
            SizedBox(height: 15),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF707070),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

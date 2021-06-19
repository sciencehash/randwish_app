import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.pink, Colors.green],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            RadiantGradientMask(
              child: Icon(
                AppIcons.current_activity_tab,
                size: 150,
                color: Colors.white,
              ),
            ),
            // Container(
            //   width: 21,
            //   height: 21.84,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [Color(0xff4f72e6), Color(0xff7a5ee8)],
            //     ),
            //   ),
            //   child: Icon(AppIcons.current_activity_tab),
            // )
          ],
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  final Widget child;

  RadiantGradientMask({
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

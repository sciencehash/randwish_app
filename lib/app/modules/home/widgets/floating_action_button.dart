import 'package:flutter/material.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.25),
            blurRadius: 6,
          ),
        ],
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff4776e6), Color(0xff8e54e9)],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          child: Icon(
            AppIcons.add_fab,
            color: Colors.white,
          ),
          onTap: () {
            print('algo');
          },
        ),
      ),
    );
  }
}

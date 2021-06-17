import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackOrHomeIconButton extends StatelessWidget {
  const BackOrHomeIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        if (Navigator.canPop(context)) {
          Get.back();
        } else {
          Get.offNamed('/');
        }
      },
    );
  }
}

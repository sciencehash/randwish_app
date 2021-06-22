import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/controllers/app_user_controller.dart';

class EnsureAppUserIsReady extends StatelessWidget {
  final Widget child;

  EnsureAppUserIsReady({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<AppUserController>()) {
      final _appUserCtrl = AppUserController.to;
      return Obx(
        () => _appUserCtrl.appUser.value != null ? child : Container(),
      );
    } else {
      return Container();
    }
  }
}

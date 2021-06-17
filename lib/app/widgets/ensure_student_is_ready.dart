import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/controllers/student_controller.dart';

class EnsureStudentIsReady extends StatelessWidget {
  final Widget child;

  EnsureStudentIsReady({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<StudentController>()) {
      final _studentCtrl = StudentController.to;
      return Obx(
        () => _studentCtrl.student.value != null ? child : Container(),
      );
    } else {
      return Container();
    }
  }
}

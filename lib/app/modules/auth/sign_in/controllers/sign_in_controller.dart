import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:randwish_app/app/controllers/auth_controller.dart';
import 'package:randwish_app/app/modules/auth/widgets/progress_indicator_dialog_content.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isSubmitting = false.obs;
  StreamSubscription? _isSubmittingSubscription;

  @override
  void onInit() {
    _listenIsSubmitting();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _isSubmittingSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _listenIsSubmitting() {
    _isSubmittingSubscription = isSubmitting.listen((value) {
      if (value) {
        // Show form submitting progress indicator
        Get.dialog(
          ProgressIndicatorDialogContent(),
          barrierDismissible: false,
        );
      } else {
        // Hide form submitting progress indicator
        if (Get.isDialogOpen!) {
          Get.back(closeOverlays: true);
        }
      }
    });
  }

  Future<void> submitForm() async {
    try {
      if (formKey.currentState!.validate()) {
        final AuthController _authController = AuthController.to;

        // Show progress indicator and disable controls
        isSubmitting.value = true;

        // Hide the keyboard - if any
        SystemChannels.textInput.invokeMethod(
          'TextInput.hide',
        );
        await _authController.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Clear fields
        emailController.clear();
        passwordController.clear();

        // Hide progress indicator and enable controls
        isSubmitting.value = false;
      }
    } catch (error) {
      // Hide progress indicator and enable controls
      isSubmitting.value = false;
      //
      Get.snackbar(
        'auth.signInErrorTitle'.tr,
        'auth.signInError'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/controllers/auth_controller.dart';
import 'package:randwish_app/app/modules/auth/widgets/progress_indicator_dialog_content.dart';

class PasswordResetController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

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
        await _authController.sendPasswordResetEmail(
          emailController.text,
        );

        // Clear fields
        emailController.clear();

        // Hide progress indicator and enable controls
        isSubmitting.value = false;

        //
        Get.snackbar(
            'auth.resetPasswordNoticeTitle'.tr, 'auth.resetPasswordNotice'.tr,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5),
            backgroundColor: Get.theme.snackBarTheme.backgroundColor,
            colorText: Get.theme.snackBarTheme.actionTextColor);
      }
    } on FirebaseAuthException catch (error) {
      // Hide progress indicator and enable controls
      isSubmitting.value = false;
      //
      Get.snackbar('auth.resetPasswordFailed'.tr, error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}

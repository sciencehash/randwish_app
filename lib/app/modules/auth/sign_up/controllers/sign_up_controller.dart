import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/controllers/auth_controller.dart';
import 'package:randwish_app/app/modules/auth/sign_up/widgets/premium_clarification_msg_dialog_content.dart';
import 'package:randwish_app/app/modules/auth/widgets/progress_indicator_dialog_content.dart';

class SignUpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
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
    // Show the premium service clarification message.
    Get.dialog(
      PremiumClarificationMsgDialogContent(),
    );

    super.onReady();
  }

  @override
  void onClose() {
    _isSubmittingSubscription?.cancel();
    nameController.dispose();
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
        await _authController.registerWithEmailAndPassword(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        // Clear fields
        nameController.clear();
        emailController.clear();
        passwordController.clear();

        // Hide progress indicator and enable controls
        isSubmitting.value = false;
      }
    } on FirebaseAuthException catch (error) {
      // Hide progress indicator and enable controls
      isSubmitting.value = false;
      //
      Get.snackbar('auth.signUpErrorTitle'.tr, error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}

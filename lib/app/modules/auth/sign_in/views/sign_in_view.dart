import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/modules/auth/widgets/form_input_field_with_icon.dart';
import 'package:randwish_app/app/modules/auth/widgets/label_button.dart';
import 'package:randwish_app/app/modules/auth/widgets/logo_graphic_header.dart';

import 'package:randwish_app/app/modules/auth/widgets/primary_button.dart';
import 'package:randwish_app/app/core/utils/helpers/validator.dart';

import 'package:randwish_app/app/widgets/back_or_home_icon_button.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  @override
  final String tag = 'signin';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackOrHomeIconButton(),
        centerTitle: true,
        title: Text('auth.signInTitle'.tr),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        LogoGraphicHeader(),
                        SizedBox(height: 48.0),
                        FormInputFieldWithIcon(
                          controller: controller.emailController,
                          iconPrefix: Icons.email,
                          labelText: 'auth.emailFormField'.tr,
                          validator: Validator().email,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                              controller.emailController.text = value!,
                          onFieldSubmitted: (_) async {
                            await controller.submitForm();
                          },
                          autofocus: true,
                          enabled: !controller.isSubmitting.value,
                        ),
                        SizedBox(height: 24),
                        FormInputFieldWithIcon(
                          controller: controller.passwordController,
                          iconPrefix: Icons.lock,
                          labelText: 'auth.passwordFormField'.tr,
                          validator: Validator().password,
                          obscureText: true,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                              controller.passwordController.text = value!,
                          onFieldSubmitted: (_) async {
                            await controller.submitForm();
                          },
                          maxLines: 1,
                          enabled: !controller.isSubmitting.value,
                        ),
                        SizedBox(height: 24),
                        PrimaryButton(
                          labelText: 'auth.signInButton'.tr,
                          onPressed: controller.isSubmitting.value
                              ? null
                              : controller.submitForm,
                        ),
                        SizedBox(height: 24),
                        LabelButton(
                          labelText: 'auth.resetPasswordLabelButton'.tr,
                          onPressed: controller.isSubmitting.value
                              ? null
                              : () => Get.offNamed('/password-reset'),
                        ),
                        LabelButton(
                          labelText: 'auth.signUpLabelButton'.tr,
                          onPressed: controller.isSubmitting.value
                              ? null
                              : () => Get.offNamed('/signup'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/core/utils/helpers/validator.dart';

import 'package:randwish_app/app/modules/auth/widgets/form_input_field_with_icon.dart';
import 'package:randwish_app/app/modules/auth/widgets/label_button.dart';
import 'package:randwish_app/app/modules/auth/widgets/logo_graphic_header.dart';
import 'package:randwish_app/app/modules/auth/widgets/primary_button.dart';
import 'package:randwish_app/app/widgets/back_or_home_icon_button.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  final String tag = 'signup';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackOrHomeIconButton(),
        centerTitle: true,
        title: Text('auth.signUpTitle'.tr),
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
                          controller: controller.nameController,
                          iconPrefix: Icons.person,
                          labelText: 'auth.nameFormField'.tr,
                          validator: Validator().name,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                              controller.nameController.text = value!,
                          onFieldSubmitted: (_) async {
                            await controller.submitForm();
                          },
                          autofocus: true,
                          enabled: !controller.isSubmitting.value,
                        ),
                        SizedBox(height: 24),
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
                          maxLines: 1,
                          onFieldSubmitted: (_) async {
                            await controller.submitForm();
                          },
                          enabled: !controller.isSubmitting.value,
                        ),
                        SizedBox(height: 24),
                        PrimaryButton(
                          labelText: 'auth.signUpButton'.tr,
                          onPressed: controller.isSubmitting.value
                              ? null
                              : controller.submitForm,
                        ),
                        SizedBox(height: 24),
                        LabelButton(
                          labelText: 'auth.signInLabelButton'.tr,
                          onPressed: controller.isSubmitting.value
                              ? null
                              : () => Get.offNamed('/login'),
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

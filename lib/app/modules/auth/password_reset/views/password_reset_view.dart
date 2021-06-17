import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/modules/auth/widgets/form_input_field_with_icon.dart';
import 'package:randwish_app/app/modules/auth/widgets/label_button.dart';
import 'package:randwish_app/app/modules/auth/widgets/logo_graphic_header.dart';
import 'package:randwish_app/app/modules/auth/widgets/primary_button.dart';
import 'package:randwish_app/app/core/utils/helpers/validator.dart';
import 'package:randwish_app/app/widgets/back_or_home_icon_button.dart';

import '../controllers/password_reset_controller.dart';

class PasswordResetView extends GetView<PasswordResetController> {
  @override
  final String tag = 'passwordreset';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackOrHomeIconButton(),
        centerTitle: true,
        title: Text('auth.resetPasswordTitle'.tr),
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
                              controller.emailController.text = value as String,
                          onFieldSubmitted: (_) async {
                            await controller.submitForm();
                          },
                          autofocus: true,
                          enabled: !controller.isSubmitting.value,
                        ),
                        SizedBox(height: 24),
                        PrimaryButton(
                          labelText: 'auth.resetPasswordButton'.tr,
                          onPressed: controller.isSubmitting.value
                              ? null
                              : controller.submitForm,
                        ),
                        SizedBox(height: 24),
                        signInLink(context),
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

  signInLink(BuildContext context) {
    if (controller.emailController.text == '') {
      return LabelButton(
        labelText: 'auth.signInonResetPasswordLabelButton'.tr,
        onPressed: controller.isSubmitting.value
            ? null
            : () => Get.offAllNamed('/login'),
      );
    }
    return Container(width: 0, height: 0);
  }
}

import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon({
    required this.controller,
    required this.iconPrefix,
    required this.labelText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines,
    required this.onChanged,
    required this.onSaved,
    this.onFieldSubmitted,
    this.autofocus,
    this.enabled,
  });

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final bool? autofocus;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(iconPrefix),
        labelText: labelText,
      ),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      autofocus: autofocus ?? false,
      enabled: enabled,
    );
  }
}

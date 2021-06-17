import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({required this.labelText, required this.onPressed});

  final String labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
      child: Text(
        labelText.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}

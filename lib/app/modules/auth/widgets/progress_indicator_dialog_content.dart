import 'package:flutter/material.dart';
import 'package:randwish_app/app/widgets/dialog_scaffold.dart';

class ProgressIndicatorDialogContent extends StatelessWidget {
  const ProgressIndicatorDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      content: CircularProgressIndicator(
        strokeWidth: 1,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';
import 'package:randwish_app/app/widgets/dialog_scaffold.dart';

class SectionItemQuantityDialogContent extends StatelessWidget {
  const SectionItemQuantityDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      maxWidth: 320,
      title: 'Recent activities',
      content: Text(
        'Select the number of activities to show in this section:',
        style: TextStyle(height: 1.4),
      ),
      buttons: Row(
        children: [
          Expanded(
            child: Text(
              '3',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          OutlinedButton(
            child: Icon(AppIcons.round_minus, size: 19),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              padding: const EdgeInsets.all(17),
              minimumSize: Size.zero,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 10),
          OutlinedButton(
            child: Icon(AppIcons.round_add, size: 19),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              padding: const EdgeInsets.all(17),
              minimumSize: Size.zero,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

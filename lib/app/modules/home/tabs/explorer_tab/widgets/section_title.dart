import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/widgets/dialogs/section_item_quantity_dialog.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF707070),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            AppIcons.section_settings,
            size: 18,
            color: Color(0xFF707070),
          ),
          onPressed: () {
            Get.dialog(
              SectionItemQuantityDialogContent(),
            );
          },
        ),
      ],
    );
  }
}

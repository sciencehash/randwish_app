import 'package:flutter/material.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';
import 'package:randwish_app/app/data/models/activity.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/widgets/activity_card.dart';
import 'package:randwish_app/app/widgets/dialog_scaffold.dart';

class RandomActivityDialogContent extends StatelessWidget {
  const RandomActivityDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      maxWidth: 330,
      title: 'Random activity',
      content: ActivityCard(
        activity: Activity(
          id: 'a',
          categoryId: 'a',
          title: 'First Activitiy',
          description: 'First description',
          tasks: [],
        ),
      ),
      buttons: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: Icon(AppIcons.random_activity),
          label: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Get another activity'.toUpperCase(),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          style: OutlinedButton.styleFrom(
            primary: Color(0xFF7560E8),
            padding: const EdgeInsets.all(17),
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5041A7),
              letterSpacing: .5,
            ),
            backgroundColor: Color(0xFF7560E8).withOpacity(.05),
          ).copyWith(
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
                return BorderSide(
                  color: Color(0xFF7560E8).withOpacity(.3),
                  width: 1,
                );
                // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

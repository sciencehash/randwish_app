import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/data/models/activity.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/controllers/explorer_tab_controller.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/widgets/activity_card.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/widgets/section_title.dart';

class SliverActivityListView extends StatelessWidget {
  final _explorerTabCtrl = Get.find<ExplorerTabController>(tag: 'explorerTab');

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SizedBox(height: 25),
            Text(
              'What do you want to do now?',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF363636),
              ),
            ),
            SizedBox(height: 15),
            SectionTitle(
              title: 'Recent activities',
            ),
            SizedBox(height: 12),
            for (Activity activity in _explorerTabCtrl.filteredActivities)
              Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: ActivityCard(
                  activity: activity,
                ),
              ),
            SizedBox(height: 12),
            SectionTitle(
              title: 'Suggested activities',
            ),
            SizedBox(height: 12),
            for (Activity activity in _explorerTabCtrl.filteredActivities)
              Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: ActivityCard(
                  activity: activity,
                ),
              ),
            // Extra bottom space
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/modules/home/tabs/activity_tab/controllers/activity_tab_controller.dart';
import 'package:randwish_app/app/widgets/view_loading_indicator.dart';

class ActivityTabView extends StatelessWidget {
  final _activityTabCtrl = Get.find<ActivityTabController>(tag: 'activityTab');

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _activityTabCtrl.isLoading.value
          ? SliverFillRemaining(
              child: ViewLoadingIndicator(),
            )
          : SliverList(
              delegate: SliverChildListDelegate(
                [Text('Activity tab')],
              ),
            ),
    );
  }
}

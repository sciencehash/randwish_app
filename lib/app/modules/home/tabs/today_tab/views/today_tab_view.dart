import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/modules/home/tabs/today_tab/controllers/today_tab_controller.dart';
import 'package:randwish_app/app/widgets/view_loading_indicator.dart';

class TodayTabView extends StatelessWidget {
  final _todayTabCtrl = Get.find<TodayTabController>(tag: 'todayTab');

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _todayTabCtrl.isLoading.value
          ? SliverFillRemaining(
              child: ViewLoadingIndicator(),
            )
          : SliverList(
              delegate: SliverChildListDelegate(
                [Text('Today tab')],
              ),
            ),
    );
  }
}

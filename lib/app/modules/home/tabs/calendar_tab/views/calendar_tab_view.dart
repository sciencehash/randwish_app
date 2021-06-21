import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/modules/home/tabs/calendar_tab/controllers/calendar_tab_controller.dart';
import 'package:randwish_app/app/widgets/view_loading_indicator.dart';

class CalendarTabView extends StatelessWidget {
  final _calendarTabCtrl = Get.find<CalendarTabController>(tag: 'calendarTab');

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _calendarTabCtrl.isLoading.value
          ? SliverFillRemaining(
              child: ViewLoadingIndicator(),
            )
          : SliverList(
              delegate: SliverChildListDelegate(
                [Text('Calendar Tab')],
              ),
            ),
    );
  }
}

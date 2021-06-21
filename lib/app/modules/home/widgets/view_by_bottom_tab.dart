import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/modules/home/controllers/home_controller.dart';
import 'package:randwish_app/app/modules/home/tabs/activity_tab/views/activity_tab_view.dart';
import 'package:randwish_app/app/modules/home/tabs/calendar_tab/views/calendar_tab_view.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/views/explorer_tab_view.dart';
import 'package:randwish_app/app/modules/home/tabs/today_tab/views/today_tab_view.dart';

class ViewByBottomTab extends StatelessWidget {
  final _homeCtrl = Get.find<HomeController>(tag: 'home');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_homeCtrl.bottomNavigationBarIndex.value == 0) {
        //
        // Explorer
        //
        return ExplorerTabView();
      } else if (_homeCtrl.bottomNavigationBarIndex.value == 1) {
        //
        // Activity
        //
        return ActivityTabView();
      } else if (_homeCtrl.bottomNavigationBarIndex.value == 2) {
        //
        // Today
        //
        return TodayTabView();
      } else {
        //
        // Calendar
        //
        return CalendarTabView();
      }
    });
  }
}

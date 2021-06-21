import 'package:get/get.dart';
import 'package:randwish_app/app/modules/home/tabs/activity_tab/controllers/activity_tab_controller.dart';
import 'package:randwish_app/app/modules/home/tabs/calendar_tab/controllers/calendar_tab_controller.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/controllers/explorer_tab_controller.dart';
import 'package:randwish_app/app/modules/home/tabs/today_tab/controllers/today_tab_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      tag: 'home',
    );
    Get.lazyPut<ExplorerTabController>(
      () => ExplorerTabController(),
      tag: 'explorerTab',
    );
    Get.lazyPut<ActivityTabController>(
      () => ActivityTabController(),
      tag: 'activityTab',
    );
    Get.lazyPut<TodayTabController>(
      () => TodayTabController(),
      tag: 'todayTab',
    );
    Get.lazyPut<CalendarTabController>(
      () => CalendarTabController(),
      tag: 'calendarTab',
    );
  }
}

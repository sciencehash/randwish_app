import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/widgets/top_bar.dart';
import 'package:randwish_app/app/modules/home/widgets/app_bar.dart';
import 'package:randwish_app/app/modules/home/widgets/bottom_navigation_bar.dart';
import 'package:randwish_app/app/modules/home/widgets/floating_action_button.dart';
import 'package:randwish_app/app/modules/home/widgets/view_by_bottom_tab.dart';
import 'package:randwish_app/app/widgets/ensure_student_is_ready.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EnsureStudentIsReady(
      child: HomeViewContent(),
    );
  }
}

class HomeViewContent extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final _homeCtrl = Get.find<HomeController>(tag: 'home');

    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        child: CustomScrollView(
          slivers: <Widget>[
            HomeAppBar(
              bottom: ExplorerTabTopBar(),
              // expandedHeight: 155,
            ),
            ViewByBottomTab(),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: HomeFloatingActionButton(),
    );
  }
}

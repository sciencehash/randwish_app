import 'package:flutter/material.dart';

import 'package:randwish_app/app/modules/home/tabs/explorer_tab/widgets/top_bar.dart';
import 'package:randwish_app/app/modules/home/widgets/app_bar.dart';
import 'package:randwish_app/app/modules/home/widgets/bottom_navigation_bar.dart';
import 'package:randwish_app/app/modules/home/widgets/floating_action_button.dart';
import 'package:randwish_app/app/modules/home/widgets/view_by_bottom_tab.dart';
import 'package:randwish_app/app/widgets/ensure_app_user_is_ready.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure that AppUser in AppUserController is ready and loaded
    return EnsureAppUserIsReady(
      child: HomeViewContent(),
    );
  }
}

class HomeViewContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        child: CustomScrollView(
          slivers: <Widget>[
            HomeAppBar(
              bottom: ExplorerTabTopBar(),
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

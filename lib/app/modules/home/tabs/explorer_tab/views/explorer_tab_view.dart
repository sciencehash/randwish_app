import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/controllers/explorer_tab_controller.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/widgets/sliver_activity_list_view.dart';
import 'package:randwish_app/app/widgets/sliver_empty_list_view.dart';
import 'package:randwish_app/app/widgets/view_loading_indicator.dart';

class ExplorerTabView extends StatelessWidget {
  final _explorerTabCtrl = Get.find<ExplorerTabController>(tag: 'explorerTab');

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _explorerTabCtrl.isLoading.value
          ? SliverFillRemaining(
              child: ViewLoadingIndicator(),
            )
          : _explorerTabCtrl.filteredActivities.isEmpty
              ? SliverEmptyListView(
                  iconData: AppIcons.explorer_tab,
                  title: 'No activities yet',
                  subtitle: 'You have not created activities yet',
                )
              : SliverActivityListView(),
    );
  }
}

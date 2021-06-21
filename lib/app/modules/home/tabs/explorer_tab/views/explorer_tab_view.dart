import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';
import 'package:randwish_app/app/modules/home/tabs/explorer_tab/controllers/explorer_tab_controller.dart';
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
          : SliverPadding(
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: ActivityCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: ActivityCard(),
                    ),
                    SizedBox(height: 12),
                    SectionTitle(
                      title: 'Suggested activities',
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: ActivityCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: ActivityCard(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: ActivityCard(),
                    ),
                    // Extra bottom space
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF707070),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            AppIcons.section_settings,
            size: 18,
            color: Color(0xFF707070),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(.1),
            offset: Offset.zero,
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(4),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        'First activity',
                        style: TextStyle(
                          fontSize: 19,
                          color: Color(0xFF363636),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'First activity description',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF707070),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            AppIcons.card_calendar,
                            size: 14,
                            color: Colors.green,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '1 day ago',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF363636),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            AppIcons.card_tasks,
                            size: 21,
                            color: Colors.green,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text(
                              '7 tasks',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF363636),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    AppIcons.card_go_arrow,
                    size: 17,
                    color: Color(0xFF363636),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            //
          },
        ),
      ),
    );
  }
}

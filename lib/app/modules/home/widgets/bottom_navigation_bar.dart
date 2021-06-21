import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';
import 'package:randwish_app/app/modules/home/controllers/home_controller.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final _homeCtrl = Get.find<HomeController>(tag: 'home');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Get.theme.bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 2,
            offset: Offset(0, -1),
          )
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Obx(
            () => CustomBottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.explorer_tab),
                  label: 'Explorer'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.activity_tab),
                  label: 'Activity'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.today_tab),
                  label: 'Your day'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.calendar_tab),
                  label: 'Calendar'.tr,
                ),
              ],
              currentIndex: _homeCtrl.bottomNavigationBarIndex.value,
              onTap: (index) {
                // _homeCtrl.removePrimaryFocus();
                _homeCtrl.bottomNavigationBarIndex.value = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (constraints.maxWidth <= 750)
            for (final item in items)
              Padding(
                padding: EdgeInsets.only(
                  left: items.indexOf(item) == items.length ~/ 2 ? 70 : 0,
                ),
                child: Tooltip(
                  message: item.label ?? '',
                  child: IconButton(
                    icon: IconTheme(
                      data: IconThemeData(
                        color: currentIndex == items.indexOf(item)
                            ? Get.theme.bottomNavigationBarTheme
                                .selectedItemColor
                            : Get.theme.bottomNavigationBarTheme
                                .unselectedItemColor,
                      ),
                      child: item.icon,
                    ),
                    onPressed: () {
                      onTap(items.indexOf(item));
                    },
                  ),
                ),
              ),
          if (constraints.maxWidth > 750)
            for (final item in items)
              Padding(
                padding: EdgeInsets.only(
                  left: items.indexOf(item) == items.length ~/ 2 ? 70 : 0,
                ),
                child: OutlinedButton.icon(
                  icon: IconTheme(
                    data: IconThemeData(
                      color: currentIndex == items.indexOf(item)
                          ? Get.theme.bottomNavigationBarTheme.selectedItemColor
                          : Get.theme.bottomNavigationBarTheme
                              .unselectedItemColor,
                    ),
                    child: item.icon,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(item.label ?? ''),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(160, 50),
                    primary: currentIndex == items.indexOf(item)
                        ? Get.theme.bottomNavigationBarTheme.selectedItemColor
                        : Get
                            .theme.bottomNavigationBarTheme.unselectedItemColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    onTap(items.indexOf(item));
                  },
                ),
              ),
        ],
      );
    });
  }
}

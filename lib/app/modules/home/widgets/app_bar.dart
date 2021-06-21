import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';

class HomeAppBar extends StatelessWidget {
  final PreferredSizeWidget? bottom;
  final double? expandedHeight;

  HomeAppBar({
    Key? key,
    this.bottom,
    this.expandedHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 2,
                offset: Offset.zero,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Material(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 55,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            AppIcons.search,
                            size: 25,
                            color: Color(0xFF707070),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Search'.tr,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF707070),
                            ),
                          ),
                        ),
                        _SuffixIconButtons(),
                        SizedBox(width: 13),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('/search');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: expandedHeight,
      bottom: bottom,
    );
  }
}

class _SuffixIconButtons extends StatelessWidget {
  _SuffixIconButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            AppIcons.notifications,
            size: 26,
            color: Color(0xFF707070),
          ),
          onPressed: () {
            Get.toNamed('/notifications');
          },
        ),
        SizedBox(width: 1),
        IconButton(
          icon: Icon(
            AppIcons.account,
            size: 25,
            color: Color(0xFF707070),
          ),
          onPressed: () {
            // _homeCtrl.removePrimaryFocus();
            Get.toNamed('/account');
          },
        ),
      ],
    );
  }
}

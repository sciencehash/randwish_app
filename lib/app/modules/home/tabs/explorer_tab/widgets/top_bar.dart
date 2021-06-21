import 'package:flutter/material.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';

class ExplorerTabTopBar extends StatelessWidget implements PreferredSizeWidget {
  const ExplorerTabTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '''Today's activities in all categories''',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF616161),
                    ),
                  ),
                ),
              ),
              IconButton(
                constraints: BoxConstraints(minHeight: 0, minWidth: 0),
                padding: const EdgeInsets.all(4),
                icon: Icon(
                  AppIcons.random_activity,
                  size: 22,
                  color: Color(0xFF7560E8),
                ),
                onPressed: () {
                  //
                },
              ),
              IconButton(
                constraints: BoxConstraints(minHeight: 0, minWidth: 0),
                padding: const EdgeInsets.all(4),
                icon: Icon(AppIcons.more_vert),
                onPressed: () {
                  //
                },
              ),
            ],
          ),
          SizedBox(height: 7),
          HorizontalDivider(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(30);
}

class HorizontalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xff4776e6).withOpacity(.5),
            Color(0xff8e54e9).withOpacity(.5),
          ],
        ),
      ),
    );
  }
}

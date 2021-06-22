import 'package:flutter/material.dart';
import 'package:randwish_app/app/core/icons/app_icons.dart';
import 'package:randwish_app/app/data/models/activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({
    Key? key,
    required this.activity,
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _CardContent(
                      activity: activity,
                    ),
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

class _CardContent extends StatelessWidget {
  const _CardContent({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          activity.title,
          style: TextStyle(
            fontSize: 19,
            color: Color(0xFF363636),
          ),
        ),
        SizedBox(height: 6),
        Text(
          activity.description,
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
                '${activity.tasks.length} tasks',
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogScaffold extends StatelessWidget {
  final String? title;
  final Widget content;
  final Widget? buttons;
  final double? maxWidth;
  final double? contentHorizontalPadding;

  DialogScaffold({
    Key? key,
    this.title,
    required this.content,
    this.buttons,
    this.maxWidth,
    this.contentHorizontalPadding = 23,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 7,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: maxWidth != null
              ? Get.width <= maxWidth!
                  ? Get.width - 20
                  : maxWidth
              : null,
          padding: const EdgeInsets.symmetric(vertical: 23),
          decoration: BoxDecoration(
            color: Get.theme.dialogTheme.backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            title!,
                            style: Get.theme.textTheme.headline6,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: contentHorizontalPadding!,
                ),
                child: content,
              ),
              if (buttons != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 30, 23, 0),
                  child: buttons!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

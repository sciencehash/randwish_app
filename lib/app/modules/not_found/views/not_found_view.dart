import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/not_found_controller.dart';

class NotFoundView extends GetView<NotFoundController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotFoundView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotFoundView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

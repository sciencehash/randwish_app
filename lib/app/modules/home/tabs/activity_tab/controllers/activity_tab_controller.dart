import 'package:get/get.dart';

class ActivityTabController extends GetxController {
  //
  // Content variables
  //

  var isLoading = true.obs;

  @override
  void onInit() {
    isLoading.value = false;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

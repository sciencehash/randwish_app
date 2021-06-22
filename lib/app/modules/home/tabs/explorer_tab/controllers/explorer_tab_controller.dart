import 'package:get/get.dart';
import 'package:randwish_app/app/data/models/activity.dart';

class ExplorerTabController extends GetxController {
  //
  // Content variables
  //

  var isLoading = true.obs;
  // var filteredActivities = [].obs;
  var filteredActivities = <Activity>[
    Activity(
      id: 'a',
      categoryId: 'a',
      title: 'First Activitiy',
      description: 'First description',
      tasks: [],
    ),
    Activity(
      id: 'b',
      categoryId: 'a',
      title: 'Second Activitiy',
      description: 'Second description',
      tasks: [],
    ),
  ].obs;

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

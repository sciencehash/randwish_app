import 'dart:typed_data';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:randwish_app/app/data/models/activity.dart';
import 'package:randwish_app/app/data/models/category.dart';
import 'package:randwish_app/app/data/providers/activity_hive_provider.dart';
import 'package:randwish_app/app/data/providers/category_hive_provider.dart';
import 'package:randwish_app/app/data/services/activity_service.dart';
import 'package:randwish_app/app/data/services/category_service.dart';

class HomeRepository {
  late CategoryService _categoryService;
  late ActivityService _activityService;

  Future<void> initProviders({required bool isLocal}) async {
    //
    // Init Category service
    //

    _categoryService = CategoryHiveProvider();
    await _categoryService.initProvider();

    //
    // Init Activity service
    //

    _activityService = ActivityHiveProvider();
    await _activityService.initProvider();
  }

  Stream<Category?> watchCategoryById(String id) {
    return _categoryService.watchById(id);
  }

  Future<String> addCategory(Category category) async {
    return await _categoryService.add(category);
  }

  Future<void> updateCategory(Category category) async {
    await _categoryService.update(category);
  }

  Future<void> removeCategoryById(String id) async {
    await _categoryService.removeById(id);
  }

  Future<List<Category>> getAllLibraries() async {
    return await _categoryService.all();
  }

  //
  //
  //

  Future<String> addActivity(
    Activity activity,
    Uint8List? data,
  ) async {
    final String newUDDId = await _activityService.add(
      activity,
    );
    return newUDDId;
  }

  Future<void> removeActivityById(String id) async {
    await _activityService.removeById(id);
  }
}

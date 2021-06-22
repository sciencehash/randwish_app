import 'dart:async';

import 'package:hive/hive.dart';
import 'package:randwish_app/app/core/utils/helpers/model.dart';
import 'package:randwish_app/app/data/models/category.dart';
import 'package:randwish_app/app/data/services/category_service.dart';

class CategoryHiveProvider extends CategoryService {
  // Hive box instance
  late Box _hiveBox;

  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('categories');
  }

  ///
  Future<Category?> byId(String id) async {
    final boxValue = _hiveBox.get(id);
    return boxValue != null
        ? Category.fromJson(Map<String, dynamic>.from(boxValue))
        : null;
  }

  ///
  Stream<Category?> watchById(String id) async* {
    var firstValue = _hiveBox.get(id);

    if (firstValue != null) {
      //
      yield Category.fromJson(
        Map<String, dynamic>.from(
          firstValue,
        ),
      );
    } else {
      yield null;
    }
    //
    yield* _hiveBox.watch(key: id).map((event) {
      return event.value != null
          ? Category.fromJson(Map<String, dynamic>.from(event.value))
          : null;
    });
  }

  ///
  Future<String> add(Category category) async {
    if (category.id == '')
      category = category.copyWith(
        id: ModelHelpers.generateID(),
      );
    await _hiveBox.put(category.id, category.toJson());
    return category.id;
  }

  ///
  Future<void> update(Category category) async {
    await _hiveBox.put(category.id, category.toJson());
  }

  ///
  Future<void> removeById(String id) async {
    await _hiveBox.delete(id);
  }

  ///
  Future<List<Category>> all() async {
    List<Category> categories = [];
    final keys = List<String>.from(_hiveBox.keys);
    for (String key in keys) {
      var value = await _hiveBox.get(key);
      categories.add(
        Category.fromJson(Map<String, dynamic>.from(value)),
      );
    }
    return categories;
  }
}

import 'dart:async';

import 'package:hive/hive.dart';
import 'package:randwish_app/app/core/utils/helpers/model.dart';
import 'package:randwish_app/app/data/models/activity.dart';
import 'package:randwish_app/app/data/services/activity_service.dart';

class ActivityHiveProvider extends ActivityService {
  // Hive box instance
  late Box _hiveBox;

  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('activities');
  }

  ///
  Future<Activity?> byId(String id) async {
    final boxValue = _hiveBox.get(id);
    return boxValue != null
        ? Activity.fromJson(Map<String, dynamic>.from(boxValue))
        : null;
  }

  ///
  Stream<Activity?> watchById(String id) async* {
    var firstValue = _hiveBox.get(id);

    if (firstValue != null) {
      //
      yield Activity.fromJson(
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
          ? Activity.fromJson(Map<String, dynamic>.from(event.value))
          : null;
    });
  }

  ///
  Future<String> add(Activity activity) async {
    if (activity.id == '')
      activity = activity.copyWith(
        id: ModelHelpers.generateID(),
      );
    await _hiveBox.put(activity.id, activity.toJson());
    return activity.id;
  }

  ///
  Future<void> update(Activity activity) async {
    await _hiveBox.put(activity.id, activity.toJson());
  }

  ///
  Future<void> removeById(String id) async {
    await _hiveBox.delete(id);
  }

  ///
  Future<List<Activity>> all() async {
    List<Activity> activities = [];
    final keys = List<String>.from(_hiveBox.keys);
    for (String key in keys) {
      var value = await _hiveBox.get(key);
      activities.add(
        Activity.fromJson(Map<String, dynamic>.from(value)),
      );
    }
    return activities;
  }
}

import 'dart:async';

import 'package:hive/hive.dart';
import 'package:randwish_app/app/data/models/student.dart';
import 'package:randwish_app/app/data/services/student_service.dart';

class StudentHiveProvider extends StudentService {
  // Hive box instance
  late Box _hiveBox;

  Future<void> initProvider() async {
    // Get Hive box instance
    _hiveBox = Hive.box('users');
  }

  ///
  Future<Student?> byId(String id) async {
    final boxValue = _hiveBox.get(id);
    return boxValue != null
        ? Student.fromJson(Map<String, dynamic>.from(boxValue))
        : null;
  }

  ///
  Stream<Student?> watchById(String id) async* {
    // Get value to the first yield from the storage
    var firstYieldValue = _hiveBox.get(id);
    // Send initial yield
    yield firstYieldValue != null
        ? Student.fromJson(
            Map<String, dynamic>.from(
              firstYieldValue,
            ),
          )
        : null;

    // Send yield for changes
    yield* _hiveBox.watch(key: id).map((event) {
      return event.value != null
          ? Student.fromJson(Map<String, dynamic>.from(event.value))
          : null;
    });
  }

  ///
  Future<void> add(Student user) async {
    await _hiveBox.put(user.id, user.toJson());
  }

  ///
  Future<void> update(Student user) async {
    await _hiveBox.put(user.id, user.toJson());
  }

  ///
  Future<void> removeById(String id) async {
    await _hiveBox.delete(id);
  }
}

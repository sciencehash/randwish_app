import 'package:randwish_app/app/data/models/student.dart';

abstract class StudentService {
  ///
  Future<void> initProvider();

  ///
  Future<Student?> byId(String id);

  ///
  Stream<Student?> watchById(String id);

  ///
  Future<void> add(Student user);

  ///
  Future<void> update(Student user);

  ///
  Future<void> removeById(String id);
}

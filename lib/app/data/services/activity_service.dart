import 'package:randwish_app/app/data/models/activity.dart';

abstract class ActivityService {
  ///
  Future<void> initProvider();

  ///
  Future<Activity?> byId(String id);

  ///
  Stream<Activity?> watchById(String id);

  ///
  Future<String> add(Activity activity);

  ///
  Future<void> update(Activity activity);

  ///
  Future<void> removeById(String id);

  ///
  Future<List<Activity>> all();
}

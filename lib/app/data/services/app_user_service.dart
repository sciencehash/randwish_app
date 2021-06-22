import 'package:randwish_app/app/data/models/app_user.dart';

abstract class AppUserService {
  ///
  Future<void> initProvider();

  ///
  Future<AppUser?> byId(String id);

  ///
  Stream<AppUser?> watchById(String id);

  ///
  Future<void> add(AppUser user);

  ///
  Future<void> update(AppUser user);

  ///
  Future<void> removeById(String id);
}

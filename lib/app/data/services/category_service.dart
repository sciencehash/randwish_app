import 'package:randwish_app/app/data/models/category.dart';

abstract class CategoryService {
  ///
  Future<void> initProvider();

  ///
  Future<Category?> byId(String id);

  ///
  Stream<Category?> watchById(String id);

  ///
  Future<String> add(Category category);

  ///
  Future<void> update(Category category);

  ///
  Future<void> removeById(String id);

  ///
  Future<List<Category>> all();
}

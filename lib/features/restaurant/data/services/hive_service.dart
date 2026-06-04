import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/restaurant_model.dart';

class HiveService {
  final Box<RestaurantModel> _box = Hive.box<RestaurantModel>("restaurantsBox");
  final Box<CategoryModel> _categoryBox = Hive.box<CategoryModel>(
    "categoriesBox",
  );

  List<RestaurantModel> getRestaurants() {
    return _box.values.toList();
  }

  Future<void> addRestaurant(RestaurantModel restaurant) async {
    await _box.add(restaurant);
  }

  List<CategoryModel> getCategories() {
    return _categoryBox.values.toList();
  }

  Future<void> addCategory(CategoryModel category) async {
    await _categoryBox.add(category);
  }

  Future<void> deleteCategory(CategoryModel category) async {
    await category.delete();
  }
}

import 'package:hive/hive.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';

part 'restaurant_model.g.dart';

@HiveType(typeId: 1)
class RestaurantModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? imagePath;
  @HiveField(2)
  final List<MealModel>? meals;
  @HiveField(3)
  final CategoryModel? category;

  RestaurantModel({
    required this.name,
    this.imagePath,
    this.meals,
    this.category,
  });
}

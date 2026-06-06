import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/category_model.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';

part 'generated/restaurant_model.g.dart';

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
  @HiveField(4)
  final String id;

  RestaurantModel({
    required this.name,
    this.imagePath,
    this.meals,
    this.category,
    String? id,
  }) : id = id ?? const Uuid().v4();

  RestaurantModel copyWith({
    String? name,
    String? imagePath,
    List<MealModel>? meals,
    CategoryModel? category,
    String? id,
  }) {
    return RestaurantModel(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      meals: meals ?? this.meals,
      category: category ?? this.category,
      id: id ?? this.id,
    );
  }
}

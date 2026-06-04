import 'package:hive_flutter/hive_flutter.dart';

part 'meal_model.g.dart';

@HiveType(typeId: 0)
class MealModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String price;
  MealModel({required this.name, required this.price});
}

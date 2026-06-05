import 'package:hive_flutter/hive_flutter.dart';

part 'generated/meal_model.g.dart';

@HiveType(typeId: 0)
class MealModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String price;
  MealModel({required this.name, required this.price});

  MealModel copyWith({String? name, String? price}) {
    return MealModel(name: name ?? this.name, price: price ?? this.price);
  }
}

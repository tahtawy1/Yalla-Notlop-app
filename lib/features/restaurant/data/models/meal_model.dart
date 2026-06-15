import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'generated/meal_model.g.dart';

@HiveType(typeId: 0)
class MealModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String price;
  MealModel({required this.name, required this.price, String? id})
    : id = id ?? const Uuid().v4();

  MealModel copyWith({String? name, String? price}) {
    return MealModel(name: name ?? this.name, price: price ?? this.price);
  }
}

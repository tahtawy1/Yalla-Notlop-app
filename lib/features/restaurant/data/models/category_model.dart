import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'generated/category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  CategoryModel({required this.name, String? id})
    : id = id ?? const Uuid().v4();

  CategoryModel copyWith({String? name, String? id}) {
    return CategoryModel(name: name ?? this.name, id: id ?? this.id);
  }
}

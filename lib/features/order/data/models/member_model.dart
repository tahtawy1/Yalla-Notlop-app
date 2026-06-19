import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:yalla_notlop_app/features/restaurant/data/models/meal_model.dart';

part 'generated/member_model.g.dart';

@HiveType(typeId: 3)
class MemberModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  List<MealModel>? meals;
  @HiveField(3)
  double? payedAmount;
  @HiveField(4)
  PayOptions? payOption;

  MemberModel({
    required this.name,
    required this.id,
    this.meals,
    this.payedAmount,
    this.payOption,
  });

  factory MemberModel.create({required String name}) {
    return MemberModel(
      name: name,
      id: const Uuid().v4(),
      meals: null,
      payedAmount: null,
      payOption: null,
    );
  }

  MemberModel copyWith({
    String? name,
    String? id,
    List<MealModel>? meals,
    double? payedAmount,
    PayOptions? payOption,
  }) {
    return MemberModel(
      name: name ?? this.name,
      id: id ?? this.id,
      meals: meals ?? this.meals,
      payedAmount: payedAmount ?? this.payedAmount,
      payOption: payOption ?? this.payOption,
    );
  }
}

@HiveType(typeId: 5)
enum PayOptions {
  @HiveField(0)
  payFullCost,
  @HiveField(1)
  payCustomCost,
  @HiveField(2)
  notPay,
}

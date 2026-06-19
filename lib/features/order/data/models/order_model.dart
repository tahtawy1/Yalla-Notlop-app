import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:yalla_notlop_app/features/order/data/models/member_model.dart';

part 'generated/order_model.g.dart';

@HiveType(typeId: 4)
class OrderModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<MemberModel> members;
  @HiveField(2)
  final double totalAmount;
  @HiveField(3)
  final DateTime orderTime;
  @HiveField(4)
  final double totalPayed;

  OrderModel({
    required this.members,
    required this.totalAmount,
    required this.orderTime,
    required this.totalPayed,
    String? id,
  }) : id = id ?? const Uuid().v4();

  OrderModel copyWith({
    String? id,
    List<MemberModel>? members,
    double? totalAmount,
    DateTime? orderTime,
    double? totalPayed,
  }) {
    return OrderModel(
      id: id ?? this.id,
      members: members ?? this.members,
      totalAmount: totalAmount ?? this.totalAmount,
      orderTime: orderTime ?? this.orderTime,
      totalPayed: totalPayed ?? this.totalPayed,
    );
  }
}

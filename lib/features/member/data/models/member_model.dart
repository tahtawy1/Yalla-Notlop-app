import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'member_model.g.dart';

@HiveType(typeId: 3)
class MemberModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;

  MemberModel({required this.name, required this.id});

  factory MemberModel.create({required String name}) {
    return MemberModel(name: name, id: const Uuid().v4());
  }

  MemberModel copyWith({String? name}) {
    return MemberModel(name: name ?? this.name, id: id);
  }
}

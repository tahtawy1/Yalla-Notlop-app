// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../meal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealModelAdapter extends TypeAdapter<MealModel> {
  @override
  final int typeId = 0;

  @override
  MealModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    // Backward compatible: old data had 2 fields (name=0, price=1)
    // New data has 3 fields (name=0, id=1, price=2)
    if (numOfFields == 2) {
      return MealModel(
        name: fields[0] as String,
        price: fields[1] as String,
      );
    }
    return MealModel(
      name: fields[0] as String,
      id: fields[1] as String?,
      price: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

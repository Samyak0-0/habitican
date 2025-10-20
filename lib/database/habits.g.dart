// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitsAdapter extends TypeAdapter<Habits> {
  @override
  final int typeId = 1;

  @override
  Habits read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habits(
      id: fields[0] as int,
      name: fields[1] as String,
      interval: fields[3] as String,
      reminder: fields[4] as String,
      iconName: fields[5] as String,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Habits obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.interval)
      ..writeByte(4)
      ..write(obj.reminder)
      ..writeByte(5)
      ..write(obj.iconName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      name: fields[0] as String,
      interval: fields[2] as String,
      reminder: fields[3] as String,
      description: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Habits obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.interval)
      ..writeByte(3)
      ..write(obj.reminder);
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

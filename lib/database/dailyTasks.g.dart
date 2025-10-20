// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyTasks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyTasksAdapter extends TypeAdapter<DailyTasks> {
  @override
  final int typeId = 3;

  @override
  DailyTasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyTasks(
      id: fields[0] as int,
      name: fields[1] as String,
      reminder: fields[3] as String,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DailyTasks obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.reminder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyTasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

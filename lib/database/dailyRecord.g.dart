// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyRecord.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyRecordAdapter extends TypeAdapter<DailyRecord> {
  @override
  final int typeId = 4;

  @override
  DailyRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyRecord(
      date: fields[0] as String,
      habitId: (fields[1] as List).cast<int>(),
      habitName: (fields[2] as List).cast<String>(),
      isHabitCompleted: (fields[3] as List).cast<bool>(),
      taskId: (fields[4] as List).cast<int>(),
      taskName: (fields[5] as List).cast<String>(),
      isTaskCompleted: (fields[6] as List).cast<bool>(),
      dailyTaskId: (fields[7] as List).cast<int>(),
      dailyTaskName: (fields[8] as List).cast<String>(),
      isDailyTaskCompleted: (fields[9] as List).cast<bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyRecord obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.habitId)
      ..writeByte(2)
      ..write(obj.habitName)
      ..writeByte(3)
      ..write(obj.isHabitCompleted)
      ..writeByte(4)
      ..write(obj.taskId)
      ..writeByte(5)
      ..write(obj.taskName)
      ..writeByte(6)
      ..write(obj.isTaskCompleted)
      ..writeByte(7)
      ..write(obj.dailyTaskId)
      ..writeByte(8)
      ..write(obj.dailyTaskName)
      ..writeByte(9)
      ..write(obj.isDailyTaskCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

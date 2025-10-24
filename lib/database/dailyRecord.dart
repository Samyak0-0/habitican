import 'package:hive/hive.dart';
part 'dailyRecord.g.dart';

@HiveType(typeId: 4)
class DailyRecord {
  DailyRecord({
    required this.date,
    this.habitId,
    this.habitName,
    this.isHabitCompleted,
    this.taskId,
    this.taskName,
    this.isTaskCompleted,
    this.dailyTaskId,
    this.dailyTaskName,
    this.isDailyTaskCompleted,
  });

  @HiveField(0)
  String date;

  @HiveField(1)
  List<int>? habitId;

  @HiveField(2)
  List<String>? habitName;

  @HiveField(3)
  List<bool>? isHabitCompleted;

  @HiveField(4)
  List<int>? taskId;

  @HiveField(5)
  List<String>? taskName;

  @HiveField(6)
  List<bool>? isTaskCompleted;

  @HiveField(7)
  List<int>? dailyTaskId;

  @HiveField(8)
  List<String>? dailyTaskName;

  @HiveField(9)
  List<bool>? isDailyTaskCompleted;

  @override
  String toString() {
    String printString = '';
    habitName?.forEach((e) {
      printString += "\t$e\t";
    });
    taskName?.forEach((e) {
      printString += "\t$e\t";
    });
    dailyTaskName?.forEach((e) {
      printString += "\t$e\t";
    });
    return '$date -- $printString --';
  }
}

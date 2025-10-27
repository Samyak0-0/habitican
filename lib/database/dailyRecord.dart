import 'package:hive/hive.dart';
part 'dailyRecord.g.dart';

@HiveType(typeId: 4)
class DailyRecord {
  DailyRecord({
    required this.date,
    required this.habitId,
    required this.habitName,
    required this.isHabitCompleted,
    required this.taskId,
    required this.taskName,
    required this.isTaskCompleted,
    required this.dailyTaskId,
    required this.dailyTaskName,
    required this.isDailyTaskCompleted,
  });

  @HiveField(0)
  String date;

  @HiveField(1)
  List<int> habitId;

  @HiveField(2)
  List<String> habitName;

  @HiveField(3)
  List<bool> isHabitCompleted;

  @HiveField(4)
  List<int> taskId;

  @HiveField(5)
  List<String> taskName;

  @HiveField(6)
  List<bool> isTaskCompleted;

  @HiveField(7)
  List<int> dailyTaskId;

  @HiveField(8)
  List<String> dailyTaskName;

  @HiveField(9)
  List<bool> isDailyTaskCompleted;

  @override
  String toString() {
    String printString = '';
    habitName.forEach((e) {
      printString += "\t$e\t";
    });
    // taskName.forEach((e) {
    //   printString += "\t$e\t";
    // });
    habitId.forEach((e) {
      printString += "\t$e\t";
    });
    isHabitCompleted.forEach((e) {
      printString += "\t$e\t";
    });
    return '$date -- $printString --';
  }
}

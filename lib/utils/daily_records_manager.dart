import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
// import 'package:hive_flutter/adapters.dart';

Future<void> dailyRecordsManager() async {
  final habitsList = boxHabits.values;
  final tasksList = boxTasks.values;
  final dailyTasksList = boxDailyTasks.values;
  final dailyRecordsBox = boxDailyRecords;

  final todayDateTime = DateTime.now();
  final todayDate = todayDateTime.toString().split(' ')[0];

  DateTime parsedDate = DateTime.parse(todayDate);
  print(parsedDate);
  print(parsedDate.runtimeType);

  // print(habitsList.values.toList()[0].id.runtimeType);

  final checkExisting = dailyRecordsBox.get(todayDate);
  print(checkExisting);

  if (checkExisting != null) {
    return;
  }
  if (dailyRecordsBox.keys.isNotEmpty) {
    final lastDailyRecord = dailyRecordsBox.keys.last;
    print(lastDailyRecord);
    Duration difference = parsedDate.difference(
      DateTime.parse(lastDailyRecord),
    );
    print(difference.inDays);
    if (difference.inDays != 0) {
      dailyRecordsBox.put(
        todayDate,
        DailyRecord(
          date: todayDate,
          habitId: habitsList.isNotEmpty
              ? habitsList.map((e) => e.id).toList() as List<int>?
              : [],
          habitName: habitsList.isNotEmpty
              ? habitsList.map((e) => e.name).toList() as List<String>?
              : [],
          isHabitCompleted: List.filled(habitsList.length, false),
          taskId: tasksList.isNotEmpty
              ? tasksList.map((e) => e.id).toList() as List<int>?
              : [],
          taskName: tasksList.isNotEmpty
              ? tasksList.map((e) => e.name).toList() as List<String>?
              : [],
          isTaskCompleted: List.filled(tasksList.length, false),
          dailyTaskId: dailyTasksList.isNotEmpty
              ? dailyTasksList.map((e) => e.id).toList() as List<int>?
              : [],
          dailyTaskName: dailyTasksList.isNotEmpty
              ? dailyTasksList.map((e) => e.name).toList() as List<String>?
              : [],
          isDailyTaskCompleted: List.filled(dailyTasksList.length, false),
        ),
      );
    }
  }
  if (checkExisting == null) {
    dailyRecordsBox.put(
      todayDate,
      DailyRecord(
        date: todayDate,
        habitId: habitsList.isNotEmpty
            ? habitsList.map((e) => e.id).toList() as List<int>?
            : [],
        habitName: habitsList.isNotEmpty
            ? habitsList.map((e) => e.name).toList() as List<String>?
            : [],
        isHabitCompleted: List.filled(habitsList.length, false),
        taskId: tasksList.isNotEmpty
            ? tasksList.map((e) => e.id).toList() as List<int>?
            : [],
        taskName: tasksList.isNotEmpty
            ? tasksList.map((e) => e.name).toList() as List<String>?
            : [],
        isTaskCompleted: List.filled(tasksList.length, false),
        dailyTaskId: dailyTasksList.isNotEmpty
            ? dailyTasksList.map((e) => e.id).toList() as List<int>?
            : [],
        dailyTaskName: dailyTasksList.isNotEmpty
            ? dailyTasksList.map((e) => e.name).toList() as List<String>?
            : [],
        isDailyTaskCompleted: List.filled(dailyTasksList.length, false),
      ),
    );
    // dailyRecordsBox.clear();
  }
  // dailyRecordsBox.clear();
  // print(todayDate);
  // print(todayDate.toString() + "aaaa");
  // print(todayDate.toLocal());
}

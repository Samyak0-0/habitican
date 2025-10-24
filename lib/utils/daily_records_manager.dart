// import 'dart:ffi';

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

  // DateTime today = DateTime(2025, 10, 24);
  // DateTime yesterday = DateTime(2025, 10, 22);
  // Duration difference = today.difference(yesterday);
  // print(difference.inDays);
  // print(difference.inHours);

  // print(parsedDate);
  // print(parsedDate.runtimeType);
  // print(habitsList.values.toList()[0].id.runtimeType);

  final checkExisting = dailyRecordsBox.get(todayDate);

  void addRecord(DateTime entryDate) {
    dailyRecordsBox.put(
      entryDate.toString().split(" ")[0],
      DailyRecord(
        date: entryDate.toString().split(" ")[0],
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

  if (checkExisting != null) {
    print(checkExisting);
    return;
  }

  if (dailyRecordsBox.keys.isEmpty) addRecord(todayDateTime);

  Duration difference = parsedDate.difference(
    DateTime.parse(dailyRecordsBox.keys.last),
  );
  for (int i = 0; i < difference.inDays; i++) {
    addRecord(parsedDate.subtract(Duration(days: i)));
  }

  // if (dailyRecordsBox.keys.isNotEmpty) {
  //   final lastDailyRecord = dailyRecordsBox.keys.last;
  //   print(lastDailyRecord);
  //   Duration difference = parsedDate.difference(
  //     DateTime.parse(lastDailyRecord),
  //   );
  //   print(difference.inDays);
  //   if (difference.inDays == 0) {
  //     addRecord();
  //   } else {
  //     for (int i = 1; i <= difference.inDays; i++) {
  //       addRecord();
  //     }
  //   }
  // } else {
  //   addRecord();
  // }
  // if (checkExisting == null) {
  //   // dailyRecordsBox.clear();
  // }
  // dailyRecordsBox.clear();
  // print(todayDate);
  // print(todayDate.toString() + "aaaa");
  // print(todayDate.toLocal());
}

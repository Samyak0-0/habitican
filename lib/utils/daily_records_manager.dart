import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/database/dailyTasks.dart';
import 'package:habitican/database/habits.dart';
import 'package:habitican/database/tasks.dart';
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
            ? (habitsList.map((e) => e.id).toList()).cast<int>()
            : [],
        habitName: habitsList.isNotEmpty
            ? (habitsList.map((e) => e.name).toList()).cast<String>()
            : [],
        isHabitCompleted: List.filled(habitsList.length, false),
        taskId: tasksList.isNotEmpty
            ? (tasksList.map((e) => e.id).toList()).cast<int>()
            : [],
        taskName: tasksList.isNotEmpty
            ? (tasksList.map((e) => e.name).toList()).cast<String>()
            : [],
        isTaskCompleted: List.filled(tasksList.length, false),
        dailyTaskId: dailyTasksList.isNotEmpty
            ? (dailyTasksList.map((e) => e.id).toList()).cast<int>()
            : [],
        dailyTaskName: dailyTasksList.isNotEmpty
            ? (dailyTasksList.map((e) => e.name).toList()).cast<String>()
            : [],
        isDailyTaskCompleted: List.filled(dailyTasksList.length, false),
      ),
    );
  }

  // await dailyRecordsBox.deleteAt(dailyRecordsBox.length - 1);
  // print(boxHabits.keys);
  if (checkExisting != null) {
    // print(checkExisting);
    return;
  }
  Future<void> resetRecords() async {
    // Use Future.wait with a for loop or .map().toList()
    await Future.wait(
      habitsList.map((e) async {
        await boxHabits.put(
          e.id,
          Habits(
            id: e.id,
            name: e.name,
            interval: e.interval,
            reminder: e.reminder,
            iconName: e.iconName,
            isCompleted: false,
          ),
        );
      }),
    );

    await Future.wait(
      tasksList.map((e) async {
        // if (e?.taskDateandReminder == null) {
        await boxTasks.put(
          e.id,
          Tasks(
            id: e.id,
            name: e.name,
            taskDateandReminder: e.taskDateandReminder,
            isCompleted: false,
          ),
        );
        // } else {
        // await boxTasks.delete(e.id);
        // }
      }),
    );

    await Future.wait(
      dailyTasksList.map((e) async {
        await boxDailyTasks.put(
          e.id,
          DailyTasks(
            id: e.id,
            name: e.name,
            reminder: e.reminder,
            isCompleted: false,
          ),
        );
      }),
    );
  }

  await resetRecords();
  if (dailyRecordsBox.keys.isEmpty) {
    addRecord(todayDateTime);
    return;
  }

  Duration difference = parsedDate.difference(
    DateTime.parse(dailyRecordsBox.keys.last),
  );
  for (int i = 0; i < difference.inDays; i++) {
    addRecord(parsedDate.subtract(Duration(days: i)));
  }
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


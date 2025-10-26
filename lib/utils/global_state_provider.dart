import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
// import 'package:habitican/database/tasks.dart';
// import 'package:hive/hive.dart';

class GlobalStateProvider extends ChangeNotifier {
  final dailyRecordsBox = boxDailyRecords;

  DateTime selectedDate = DateTime.now();
  DailyRecord? selectedDateRecord = boxDailyRecords.get(
    DateTime.now().toString().split(" ")[0],
  );

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    selectedDateRecord = boxDailyRecords.get(
      selectedDate.toString().split(" ")[0],
    );
    notifyListeners();
  }

  // Derived values — return 0 if the selectedDateRecord is null
  int get completedHabits =>
      selectedDateRecord?.isHabitCompleted.where((e) => e == true).length ?? 0;

  int get completedTasks =>
      selectedDateRecord?.isTaskCompleted.where((e) => e == true).length ?? 0;

  int get completedDailyTasks =>
      selectedDateRecord?.isDailyTaskCompleted.where((e) => e == true).length ??
      0;

  int get habitLength => selectedDateRecord?.isHabitCompleted.length ?? 0;

  int get taskLength => selectedDateRecord?.isTaskCompleted.length ?? 0;

  int get dailyTasksLength =>
      selectedDateRecord?.isDailyTaskCompleted.length ?? 0;

  double get habitPercent =>
      habitLength > 0 ? completedHabits / habitLength : 0;

  double get taskPercent => taskLength > 0 ? completedTasks / taskLength : 0;

  double get dailyTaskPercent =>
      dailyTasksLength > 0 ? completedDailyTasks / dailyTasksLength : 0;

  final habitsList = boxHabits.values;
  final tasksList = boxTasks.values;
  final dailyTasksList = boxDailyTasks.values;

  final todayDateTime = DateTime.now();
  String get todayDate => todayDateTime.toString().split(' ')[0];

  DateTime get parsedDate => DateTime.parse(todayDate);

  void updateRecord(DateTime entryDate) {
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
    notifyListeners();
  }
  // BoxCollection? myCollection;

  // List<Tasks> completedTasks = [];

  // void pushTask(Tasks task) {
  //   completedTasks.add(task);
  // }

  // void removeTask(Tasks task) {
  //   completedTasks.remove(task);
  // }

  // GlobalStateProvider() {
  //   _initHive();
  // }

  // Future<void> _initHive() async {
  //   // Open the collection asynchronously
  //   myCollection = await BoxCollection.open(
  //     'Habitician',
  //     {'habits', 'tasks', 'daily tasks'},
  //   );

  //   // Notify listeners once initialization is done
  //   notifyListeners();
  // }
}

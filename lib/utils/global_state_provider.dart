import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/database/tasks.dart';
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

  double get totalTaskPercent => (taskLength + dailyTasksLength) > 0
      ? (completedTasks + completedDailyTasks) / (taskLength + dailyTasksLength)
      : 0;

  final habitsList = boxHabits.values;
  final tasksList = boxTasks.values;
  final dailyTasksList = boxDailyTasks.values;

  final todayDateTime = DateTime.now();
  String get todayDate => todayDateTime.toString().split(' ')[0];

  DateTime get parsedDate => DateTime.parse(todayDate);

  void updateRecord(DateTime entryDate) {
    // Read the latest box values at update time to avoid stale snapshots
    final currentHabits = boxHabits.values;
    final currentTasks = boxTasks.values;
    final currentDailyTasks = boxDailyTasks.values;

    dailyRecordsBox.put(
      entryDate.toString().split(" ")[0],
      DailyRecord(
        date: entryDate.toString().split(" ")[0],
        habitId: currentHabits.isNotEmpty
            ? (currentHabits.map((e) => e.id).toList()).cast<int>()
            : [],
        habitName: currentHabits.isNotEmpty
            ? (currentHabits.map((e) => e.name).toList()).cast<String>()
            : [],
        isHabitCompleted: currentHabits.isNotEmpty
            ? (currentHabits.map((e) => e.isCompleted).toList()).cast()
            : [],
        taskId: currentTasks.isNotEmpty
            ? (currentTasks.map((e) => e.id).toList()).cast<int>()
            : [],
        taskName: currentTasks.isNotEmpty
            ? (currentTasks.map((e) => e.name).toList()).cast<String>()
            : [],
        isTaskCompleted: currentTasks.isNotEmpty
            ? (currentTasks.map((e) => e.isCompleted).toList()).cast()
            : [],
        dailyTaskId: currentDailyTasks.isNotEmpty
            ? (currentDailyTasks.map((e) => e.id).toList()).cast<int>()
            : [],
        dailyTaskName: currentDailyTasks.isNotEmpty
            ? (currentDailyTasks.map((e) => e.name).toList()).cast<String>()
            : [],
        isDailyTaskCompleted: currentDailyTasks.isNotEmpty
            ? (currentDailyTasks.map((e) => e.isCompleted).toList()).cast()
            : [],
      ),
    );

    // Refresh the cached selectedDateRecord so getters reflect the latest box state
    selectedDateRecord = dailyRecordsBox.get(
      selectedDate.toString().split(" ")[0],
    );

    // Notify listeners so UI that depends on this provider (e.g. calendar/tracker)
    // will rebuild and show updated percentages.
    notifyListeners();
  }

  //
  // List<Tasks> tasks = boxTasks.values.toList().cast<Tasks>();
  // void makeMostImpTask(Tasks task) {
  //   tasks.remove(task);
  //   tasks = [task, ...tasks];
  //   notifyListeners();
  // }

  //
  List<int> selectedDays = [];
  void toggleDays(int index) {
    selectedDays.contains(index)
        ? selectedDays.remove(index)
        : selectedDays.add(index);
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

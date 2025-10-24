import 'package:flutter/material.dart';
// import 'package:habitican/database/tasks.dart';
// import 'package:hive/hive.dart';

class GlobalStateProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();

  void setSelectedDate(DateTime date) {
    selectedDate = date;
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

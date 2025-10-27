import 'package:flutter/material.dart';
import 'package:habitican/components/to_do_cards.dart';
import 'package:habitican/components/to_do_records.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/database/tasks.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoList extends StatefulWidget {
  final DateTime selectedDate;
  const ToDoList({super.key, required this.selectedDate});
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  // List<dynamic> taskList = boxTasks.values.toList();
  // void _reorderTasks() {
  //   taskList.sort((a, b) {
  //     if (a.isDone == b.isDone) return 0;
  //     return a.isDone ? 1 : -1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Duration timeDiff = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(widget.selectedDate);

    if (timeDiff.inDays >= 1) {
      DailyRecord? selectedDaysRecord = boxDailyRecords.get(
        widget.selectedDate.toString().split(" ")[0],
      );

      if (selectedDaysRecord == null) {
        return Text("No records found! :(");
      }
      // boxDailyRecords.values.map((e))
      return ListView.builder(
        itemCount: selectedDaysRecord.taskName.length,
        itemBuilder: (context, index) {
          return ToDoRecords(
            index: index + 1,
            name: selectedDaysRecord.taskName[index],
            isCompleted: selectedDaysRecord.isTaskCompleted[index],
          );
        },
      );
    }

    return ValueListenableBuilder(
      valueListenable: boxTasks.listenable(),
      builder: (context, value, child) {
        List<Tasks> tasks = boxTasks.values.toList().cast<Tasks>();
        tasks.sort((a, b) {
          if (a.isCompleted == b.isCompleted) return 0;
          return a.isCompleted ? 1 : -1;
        });

        return ListView.builder(
          itemCount: boxTasks.length,
          itemBuilder:
              (
                context,
                index,
              ) {
                Tasks task = tasks[index];
                print(task.description);
                // print(boxTasks.keys);
                // print(task.toString());

                // return const Placeholder();
                return ToDoCards(
                  id: task.id,
                  name: task.name,
                  taskDateandReminder: task.taskDateandReminder!,
                  isCompleted: task.isCompleted,
                  description: task.description,
                  // reOrderFunction: _reorderTasks,
                );
              },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habitican/components/to_do_cards.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/tasks.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Tasks> completedTasks = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxTasks.listenable(),
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: boxTasks.length,
          itemBuilder: (context, index) {
            Tasks task = boxTasks.getAt(index);
            print(boxTasks.keys);
            print(task.toString());

            // return const Placeholder();
            return ToDoCards(
              id: task.id,
              name: task.name,
              taskDateandReminder: task.taskDateandReminder,
            );
          },
        );
      },
    );
  }
}

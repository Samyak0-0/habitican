import 'package:flutter/material.dart';
import 'package:habitican/components/to_do_cards.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/tasks.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boxTasks.length,
      itemBuilder: (context, index) {
        Tasks task = boxTasks.getAt(index);

        // return const Placeholder();
        return ToDoCards(
          name: task.name,
          taskDateandReminder: task.taskDateandReminder,
        );
      },
    );
  }
}

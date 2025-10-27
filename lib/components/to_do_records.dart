import 'package:flutter/material.dart';

class ToDoRecords extends StatelessWidget {
  final int index;
  final String name;
  final bool isCompleted;
  const ToDoRecords({
    super.key,
    required this.index,
    required this.name,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: Text(index.toString()),
      trailing: Text(isCompleted ? "Completed" : "Not Completed"),
    );
  }
}

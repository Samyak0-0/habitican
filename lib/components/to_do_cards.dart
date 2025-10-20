import 'package:flutter/material.dart';

class ToDoCards extends StatelessWidget {
  final String name;
  final String? description;
  final String interval;
  final String reminder;
  const ToDoCards({
    super.key,
    required this.name,
    this.description,
    required this.interval,
    required this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    if (description != null) {
      return ListTile(
        title: Row(
          children: [Text(name), Text(interval), Text(reminder)],
        ),
        subtitle: Text(description!),
        trailing: Icon(Icons.menu),
      );
    } else {
      return ListTile(
        title: Row(
          children: [Text(name), Text(interval), Text(reminder)],
        ),
        trailing: Icon(Icons.menu),
      );
    }
  }
}

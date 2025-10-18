import 'package:flutter/material.dart';

class Habitcards extends StatelessWidget {
  final String name;
  final String? description;
  final String interval;
  final String reminder;
  final IconData habitIcon;
  const Habitcards({
    super.key,
    required this.name,
    this.description,
    required this.interval,
    required this.reminder,
    required this.habitIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (description != "") {
      return ListTile(
        title: Text(name),
        subtitle: Text(description!),
        leading: Icon(habitIcon),
        trailing: Icon(Icons.menu),
      );
    } else {
      return ListTile(
        title: Text(name),
        leading: Icon(habitIcon),
        trailing: Icon(Icons.menu),
      );
    }
  }
}

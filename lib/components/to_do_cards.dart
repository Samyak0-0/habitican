import 'package:flutter/material.dart';

class ToDoCards extends StatelessWidget {
  final String name;
  const ToDoCards({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      width: double.infinity,
      child: Text(name),
    );
  }
}

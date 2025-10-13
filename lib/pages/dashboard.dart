import 'package:flutter/material.dart';
import 'package:habitican/components/habit_list.dart';
import 'package:habitican/components/to_do_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int habitToDoIndex = 0;

  List<Widget> pages = [
    HabitList(),
    ToDoList(),
  ];

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [],
            ),
            Icon(Icons.account_circle),
          ],
        ),
        Placeholder(),
        Text("Today ' s"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Chip(label: Text("Habits")),
                Chip(label: Text("Tasks")),
              ],
            ),
            Icon(Icons.replay_circle_filled_rounded),
          ],
        ),
        IndexedStack(
          index: 0,
          children: [],
        ),
      ],
    );
  }
}

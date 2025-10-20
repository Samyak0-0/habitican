import 'package:flutter/material.dart';
import 'package:habitican/components/habit_cards.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/habits.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitList extends StatefulWidget {
  const HabitList({super.key});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  Box habitsList = boxHabits;

  @override
  Widget build(BuildContext context) {
    // for (var habit in habitsList.values) {
    //   print('Habit: ${habit.name}, Streak: ${habit.interval}');
    // }
    // print(habitsList.values.toList()[0].name);

    return ValueListenableBuilder(
      valueListenable: boxHabits.listenable(),
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: habitsList.length,
          itemBuilder: (context, index) {
            Habits habit = boxHabits.getAt(index);
            return Habitcards(
              name: habit.name,
              interval: habit.interval,
              reminder: habit.reminder,
              habitIconName: habit.iconName,
              description: habit.description,
            );
          },
        );
      },
    );
  }
}

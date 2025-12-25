import 'package:flutter/material.dart';
import 'package:habitican/components/habit_cards.dart';
import 'package:habitican/components/habit_records.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/database/habits.dart';
import 'package:habitican/utils/notifications_utils.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitList extends StatefulWidget {
  final DateTime selectedDate;
  const HabitList({super.key, required this.selectedDate});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  Box habitsList = boxHabits;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Duration timeDiff = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(widget.selectedDate);
    // print('affffff ${timeDiff.inDays} ${widget.selectedDate}');

    // if(timeDiff.inDays >= 1) {

    // }
    if (timeDiff.inDays >= 1) {
      DailyRecord? selectedDaysRecord = boxDailyRecords.get(
        widget.selectedDate.toString().split(" ")[0],
      );

      if (selectedDaysRecord == null) {
        return Text("No records found! :(");
        // return ElevatedButton(
        //   onPressed: () {
        //     NotificationsUtils().scheduleNotifications(
        //       title: "YOOOOOO",
        //       body: "Chatttttttttt!!!!",
        //       hour: DateTime.now().hour,
        //       minute: DateTime.now().minute + 1,
        //     );
        //   },
        //   child: Text("Schedule notifications"),
        // );
      }
      // boxDailyRecords.values.map((e))
      return ListView.builder(
        itemCount: selectedDaysRecord.habitName.length,
        itemBuilder: (context, index) {
          return HabitRecords(
            index: index + 1,
            name: selectedDaysRecord.habitName[index],
            isCompleted: selectedDaysRecord.isHabitCompleted[index],
          );
        },
      );
    }
    // for (var habit in habitsList.values) {
    //   print('Habit: ${habit.name}, Streak: ${habit.interval}');
    // }
    // print(habitsList.values.toList()[0].name);

    return ValueListenableBuilder(
      valueListenable: boxHabits.listenable(),
      builder: (context, value, child) {
        List<Habits> habits = boxHabits.values.toList().cast<Habits>();
        habits.sort((a, b) {
          if (a.isCompleted == b.isCompleted) return 0;
          return a.isCompleted ? 1 : -1;
        });

        return ListView.builder(
          itemCount: habitsList.length,
          itemBuilder: (context, index) {
            // Habits habit = boxHabits.getAt(index);
            Habits habit = habits[index];
            // print('${habit.id} -- ${habit.name}');
            return Habitcards(
              id: habit.id,
              name: habit.name,
              interval: habit.interval,
              reminder: habit.reminder,
              habitIconName: habit.iconName,
              description: habit.description,
              isCompleted: habit.isCompleted,
            );
          },
        );
      },
    );
  }
}

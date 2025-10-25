import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/utils/calendarr.dart';
import 'package:habitican/utils/day_progress_circular_bar.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:table_calendar/table_calendar.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalStateProvider>(context);
    final selectedDate = globalState.selectedDate;

    DailyRecord? selectedDateRecord = boxDailyRecords.get(
      selectedDate.toString().split(" ")[0],
    );

    if (selectedDateRecord == null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Your Progress Report"),
            ],
          ),
          const SizedBox(
            height: 500,
            child: MonthlyScreen(),
          ),
          // DayProgressCircularBar(),
          Expanded(
            child: ListView(
              children: [
                Text('Daily Insights'),
                Text(selectedDate.toString()),
                Text("No Record for the given date present :( "),
                Text("View Details ->"),
              ],
            ),
          ),
        ],
      );
    }

    int completedHabits =
        selectedDateRecord.isHabitCompleted?.where((e) => e == true).length ??
        0;
    int completedTasks =
        selectedDateRecord.isTaskCompleted?.where((e) => e == true).length ?? 0;
    int completedDailyTasks =
        selectedDateRecord.isDailyTaskCompleted
            ?.where((e) => e == true)
            .length ??
        0;

    int habitLength = selectedDateRecord.isHabitCompleted!.length;
    int taskLength = selectedDateRecord.isTaskCompleted!.length;
    int dailyTasksLength = selectedDateRecord.isDailyTaskCompleted!.length;

    double habitPercent = selectedDateRecord.isHabitCompleted!.isNotEmpty
        ? completedHabits / habitLength
        : 0;
    double taskPercent = selectedDateRecord.isTaskCompleted!.isNotEmpty
        ? completedHabits / taskLength
        : 0;
    double dailyTaskPercent =
        selectedDateRecord.isDailyTaskCompleted!.isNotEmpty
        ? completedHabits / dailyTasksLength
        : 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.navigate_before),
            // Text("October, 2025"),
            // Icon(Icons.navigate_next),
            const Text("Your Progress Report"),
          ],
        ),
        const SizedBox(
          height: 500,
          child: MonthlyScreen(),
        ),
        // DayProgressCircularBar(),
        Expanded(
          child: ListView(
            children: [
              Text('Daily Insights'),
              Text(selectedDate.toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Habits Completed: $completedHabits / $habitLength"),
                      Text(
                        "Task Completed: ${completedTasks + completedDailyTasks} / ${taskLength + dailyTasksLength}",
                      ),
                    ],
                  ),
                  DayProgressCircularBar(
                    date: '1',
                    habitPercent: habitPercent,
                    taskPercent: (taskPercent + dailyTaskPercent) / 2,
                  ),
                ],
              ),
              Text("View Details ->"),
            ],
          ),
        ),
      ],
    );
  }
}

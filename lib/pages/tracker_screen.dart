import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyRecord.dart';
import 'package:habitican/utils/calendarr.dart';
import 'package:habitican/utils/day_progress_circular_bar.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
    final selectedDateRecord = globalState.selectedDateRecord;

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
                      Text(
                        "Habits Completed: ${globalState.completedHabits} / ${globalState.habitLength}",
                      ),
                      Text(
                        "Task Completed: ${globalState.completedTasks + globalState.completedDailyTasks} / ${globalState.taskLength + globalState.dailyTasksLength}",
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: boxDailyRecords.listenable(),
                    builder: (context, value, child) {
                      return DayProgressCircularBar(
                        date: selectedDate.day.toString(),
                        habitPercent: globalState.habitPercent,
                        taskPercent: globalState.totalTaskPercent,
                        transparent: false,
                        sizeMultiplier: 2,
                        widthMulitplier: 2,
                      );
                    },
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

import 'package:flutter/material.dart';
import 'package:habitican/utils/calendarr.dart';
import 'package:habitican/utils/day_progress_circular_bar.dart';
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
            children: const [
              Text('Daily Insights'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Habits Completed: 7/9"),
                      Text("Task Completed: 9/11"),
                    ],
                  ),
                  DayProgressCircularBar(date: '1'),
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

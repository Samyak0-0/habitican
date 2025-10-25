import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class DayProgressCircularBar extends StatelessWidget {
  final double habitPercent;
  final double taskPercent;
  final String date;
  const DayProgressCircularBar({
    super.key,
    this.habitPercent = 0.85,
    this.taskPercent = 0.65,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 22.0,
      lineWidth: 5.0,
      percent: habitPercent,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.transparent,
      progressColor: Colors.green,

      center: CircularPercentIndicator(
        radius: 15.0,
        lineWidth: 5.0,
        percent: taskPercent,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Colors.transparent,
        progressColor: Colors.red,
        center: Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

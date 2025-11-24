import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class DayProgressCircularBar extends StatelessWidget {
  final double habitPercent;
  final double taskPercent;
  final String date;
  final bool transparent;
  final double sizeMultiplier;
  final double widthMulitplier;
  const DayProgressCircularBar({
    super.key,
    this.habitPercent = 0.85,
    this.taskPercent = 0.65,
    this.transparent = true,
    this.sizeMultiplier = 1,
    this.widthMulitplier = 1,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 22.0 * sizeMultiplier,
      lineWidth: 5.0 * widthMulitplier,
      percent: habitPercent,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: transparent ? Colors.transparent : Colors.grey.shade400,
      progressColor: Colors.green,

      center: CircularPercentIndicator(
        radius: 15.0 * sizeMultiplier,
        lineWidth: 5.0 * widthMulitplier,
        percent: taskPercent,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: transparent
            ? Colors.transparent
            : Colors.grey.shade400,
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

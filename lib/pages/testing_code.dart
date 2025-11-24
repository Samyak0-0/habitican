import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Add in pubspec.yaml

class FitnessCalendar extends StatelessWidget {
  FitnessCalendar({super.key});
  final int totalDays = 30;
  final List<int> completedDays = [1, 2, 5, 7, 8, 9, 13, 14, 15, 19, 20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("September"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: totalDays,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            int day = index + 1;
            bool reached = completedDays.contains(day);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 22,
                  lineWidth: 4,
                  percent: reached ? 1.0 : 0.3,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: reached ? Colors.pinkAccent : Colors.grey,
                  backgroundColor: Colors.black54,
                  center: Icon(
                    Icons.favorite,
                    color: reached ? Colors.pinkAccent : Colors.grey[800],
                    size: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$day",
                  style: TextStyle(
                    color: reached ? Colors.white : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

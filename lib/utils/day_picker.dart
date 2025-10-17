import 'package:flutter/material.dart';

class DayPicker extends StatefulWidget {
  const DayPicker({super.key});

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  final daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  String? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: daysOfWeek.map((String day) {
        if (day == "Sunday") {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedDay = day;
                });
              },
              child: CircleAvatar(
                // backgroundColor: const Color.fromARGB(255, 255, 71, 71),
                radius: 20,
                child: Text(
                  day[0],
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = day;
                debugPrint(selectedDay);
              });
            },
            child: CircleAvatar(radius: 20, child: Text(day[0])),
          ),
        );
      }).toList(),
    );
  }
}

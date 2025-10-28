import 'package:flutter/material.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';

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
  List<int> daysofWeek = List.generate(7, (index) => index + 1);
  List<int> get selectedDays =>
      Provider.of<GlobalStateProvider>(context).selectedDays;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: daysOfWeek.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final day = entry.value;
        if (index == 7) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Provider.of<GlobalStateProvider>(
                    context,
                    listen: false,
                  ).toggleDays(index);
                });
              },
              child: CircleAvatar(
                backgroundColor: selectedDays.contains(index)
                    ? Color.fromARGB(255, 178, 237, 107)
                    : Color.fromARGB(255, 167, 168, 169),
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
                Provider.of<GlobalStateProvider>(
                  context,
                  listen: false,
                ).toggleDays(index);
              });
            },
            child: CircleAvatar(
              backgroundColor: selectedDays.contains(index)
                  ? Color.fromARGB(255, 178, 237, 107)
                  : Color.fromARGB(255, 167, 168, 169),
              radius: 20,
              child: Text(day[0]),
            ),
          ),
        );
      }).toList(),
    );
  }
}

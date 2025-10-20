import 'package:flutter/material.dart';
import 'package:habitican/pages/habit_add_screen.dart';
import 'package:habitican/pages/task_add_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final List<String> _optionsList = [
    'Habit',
    'Task',
  ];
  String _selectedAddType = "Habit";
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? finalSelectedTime;
  // Habits habitsList = boxHabits.getAt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('X'),
            Text(
              _selectedAddType == "Habit"
                  ? 'Start a New\t\t\t'
                  : 'Add a New\t\t\t',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 100,
              child: DropdownButtonFormField(
                // itemHeight: 50,
                // hint: Text('Select an option'),
                initialValue: _selectedAddType,
                items: _optionsList
                    .map(
                      (String e) => DropdownMenuItem(
                        value: e,
                        child: Text("$e!"),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedAddType = newValue
                        .toString(); // Update the selected value
                  });
                },
                // decoration: InputDecoration(
                //   border: OutlineInputBorder(), // Optional border decoration
                // ),
              ),
            ),
          ],
        ),
      ),
      body: _selectedAddType == "Habit" ? HabitAddScreen() : TaskAddScreen(),
    );
  }
}

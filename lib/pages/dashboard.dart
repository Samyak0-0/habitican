import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:habitican/components/habit_list.dart';
import 'package:habitican/components/to_do_list.dart';
import 'package:habitican/pages/account_screen.dart';
import 'package:intl/intl.dart';
// import 'package:intl';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final todayDate = DateFormat("dd MMM, yyyy").format(DateTime.now());
  String _selectedValue = DateTime.now().toString();

  // Controller to programmatically scroll/animate the DatePicker
  final DatePickerController _datePickerController = DatePickerController();

  int habitToDoIndex = 0;

  // Generate the children using the current _selectedValue so they rebuild
  // whenever _selectedValue changes (setState called by DatePicker).
  List<Widget> get habitToDoLists => [
    HabitList(
      key: ValueKey('habits_$_selectedValue'),
      selectedDate: DateTime.parse(_selectedValue),
    ),
    ToDoList(
      key: ValueKey('tasks_$_selectedValue'),
      selectedDate: DateTime.parse(_selectedValue),
    ),
  ];

  @override
  void initState() {
    super.initState();

    // After first frame, animate the DatePicker to its initial selection.
    // We use a post-frame callback so the DatePicker has attached the
    // controller in its own initState.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        _datePickerController.animateToSelection(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        // If something goes wrong, ignore to avoid crashing the app on launch.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text('Welcome Samyak'),

                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    Text(todayDate),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AccountScreen();
                    },
                  ),
                );
              },
              child: const Icon(Icons.account_circle),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.navigate_before),
            Text("October, 2025"),
            Icon(Icons.navigate_next),
          ],
        ),
        SizedBox(
          height: 100,
          child: DatePicker(
            /* 
            Needs logic to Start Counting from when user joined to App
            till the current day it is today.
            */
            DateTime(2025, 10, 20),
            // Use the same selected value for initial selection so the
            // controller can animate to the correct date on launch.
            initialSelectedDate: DateTime.parse(_selectedValue),
            controller: _datePickerController,
            width: 60,
            daysCount: 100,
            // monthTextStyle: TextStyle(color: Colors.white),
            // dateTextStyle: TextStyle(),
            // dayTextStyle: TextStyle(),
            selectionColor: const Color.fromRGBO(158, 187, 31, 1),
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              // New date selected
              setState(() {
                _selectedValue = date.toString();
                // print(_selectedValue);
              });
            },
          ),
        ),
        const Text("Today ' s"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 12, 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        habitToDoIndex = 0;
                      });
                    },
                    child: Chip(
                      backgroundColor: habitToDoIndex == 0
                          ? Colors.green
                          : null,
                      label: Text(
                        "Habits",
                        style: TextStyle(
                          color: habitToDoIndex == 0
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      habitToDoIndex = 1;
                    });
                  },
                  child: Chip(
                    backgroundColor: habitToDoIndex == 1 ? Colors.green : null,
                    label: Text(
                      "Tasks",
                      style: TextStyle(
                        color: habitToDoIndex == 1
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Icon(Icons.replay_circle_filled_rounded),
          ],
        ),
        Expanded(
          child: IndexedStack(
            index: habitToDoIndex,
            children: habitToDoLists,
          ),
        ),
      ],
    );
  }
}

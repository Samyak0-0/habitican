import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyTasks.dart';
import 'package:habitican/database/tasks.dart';
import 'package:intl/intl.dart';

enum _TaskTypeList {
  oneTime('One-time'),
  daily('Daily');

  final String displayName;
  const _TaskTypeList(this.displayName);
}

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final TextEditingController _inputField = TextEditingController();
  final TextEditingController _descriptionField = TextEditingController();
  _TaskTypeList? _selectedTaskType;

  DateTime? selectedDate;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? finalSelectedTime;
  final newTaskId = (boxTasks.isEmpty)
      ? 1
      : boxTasks.values.map((h) => h.id).reduce((a, b) => a > b ? a : b) + 1;
  final newDailyTaskId = (boxDailyTasks.isEmpty)
      ? 1
      : boxDailyTasks.values.map((h) => h.id).reduce((a, b) => a > b ? a : b) +
            1;
  // Habits habitsList = boxHabits.getAt(0);

  @override
  Widget build(BuildContext context) {
    Future<void> handleDateTimeSelection() async {
      if (!mounted || !context.mounted) return;
      DateTime today = DateTime.now();

      final DateTime? taskDate = await showDatePicker(
        context: context,
        firstDate: DateTime(
          today.year,
          today.month,
          today.day,
        ),
        lastDate: DateTime(today.year + 2),
      );

      if (!mounted || !context.mounted || taskDate == null) return;

      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (!mounted || timeOfDay == null) return;

      setState(() {
        selectedTime = timeOfDay;
        finalSelectedTime = timeOfDay;
        selectedDate = taskDate;
      });
    }

    Future<void> handleTimeSelection() async {
      if (!mounted || !context.mounted) return;

      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (!mounted || timeOfDay == null) return;

      setState(() {
        selectedTime = timeOfDay;
        finalSelectedTime = timeOfDay;
      });
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Name',
            ),
            TextField(
              controller: _inputField,
            ),
            const Text('Description'),
            TextField(
              controller: _descriptionField,
            ),

            const Text('Type'),
            SizedBox(
              // width: 200,
              child: DropdownButtonFormField(
                // itemHeight: 50,
                hint: Text('Select an option'),
                initialValue: _selectedTaskType,
                items: _TaskTypeList.values
                    .map(
                      (taskType) => DropdownMenuItem(
                        value: taskType,
                        child: Text('${taskType.displayName} task'),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedTaskType = newValue; // Update the selected value
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(), // Optional border decoration
                ),
              ),
            ),

            Row(
              children: [
                const Expanded(child: Text('Reminders')),
                ElevatedButton(
                  onPressed: _selectedTaskType == _TaskTypeList.oneTime
                      ? handleDateTimeSelection
                      : handleTimeSelection,
                  child: Text(
                    _selectedTaskType == _TaskTypeList.daily
                        ? finalSelectedTime != null
                              ? '${finalSelectedTime?.format(context)}'
                              : "None"
                        : selectedDate != null
                        ? '${DateFormat("E, MMM dd").format(selectedDate!)}, ${finalSelectedTime?.format(context)}'
                        : "None",
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      finalSelectedTime = null;
                      selectedDate = null;
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  if (_selectedTaskType != null &&
                      finalSelectedTime?.format(context) != null) {
                    if (_selectedTaskType == _TaskTypeList.oneTime) {
                      boxTasks.put(
                        _inputField.text,
                        Tasks(
                          id: 1,
                          name: _inputField.text,
                          taskDate: selectedDate.toString(),
                          reminder: finalSelectedTime!.format(context),
                          description: _descriptionField.text,
                        ),
                      );
                    } else {
                      boxDailyTasks.put(
                        _inputField.text,
                        DailyTasks(
                          id: 1,
                          name: _inputField.text,
                          reminder: finalSelectedTime!.format(context),
                          description: _descriptionField.text,
                        ),
                      );
                    }
                  }
                });
                // print('asa');
                // debugPrint(_inputField.text);
                // debugPrint(_descriptionField.text);
                // debugPrint(_selectedTaskType);
                // debugPrint(finalSelectedTime?.format(context));
              },
              child: Text('Save'),
            ),
            // Text(habitsList.name),
            // if (habitsList.description != null)
            //   Text(habitsList.description ?? ""),
            // Text(habitsList.interval),
            // Text(habitsList.reminder),
          ],
        ),
      ),
    );
  }
}

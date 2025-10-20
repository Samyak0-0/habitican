import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/tasks.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final TextEditingController _inputField = TextEditingController();
  final TextEditingController _descriptionField = TextEditingController();
  final List<String> _taskTypeList = [
    'One-time',
    'Daily',
  ];
  String? _selectedTaskType;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? finalSelectedTime;
  // Habits habitsList = boxHabits.getAt(0);

  @override
  Widget build(BuildContext context) {
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
                items: _taskTypeList
                    .map(
                      (String e) => DropdownMenuItem(
                        value: e,
                        child: Text('$e task'),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
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
                  onPressed: () async {
                    final TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (timeOfDay != null) {
                      setState(() {
                        selectedTime = timeOfDay;
                        finalSelectedTime = timeOfDay;
                      });
                    }
                  },
                  child: Text(
                    finalSelectedTime != null
                        ? '${finalSelectedTime?.format(context)}'
                        : "None",
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      finalSelectedTime = null;
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
                    boxTasks.put(
                      _inputField.text,
                      Tasks(
                        id: 1,
                        name: _inputField.text,
                        taskDate: _selectedTaskType!,
                        reminder: finalSelectedTime!.format(context),
                        description: _descriptionField.text,
                      ),
                    );
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

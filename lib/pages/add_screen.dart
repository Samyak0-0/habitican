import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/habits.dart';
import 'package:habitican/utils/day_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _inputField = TextEditingController();
  final TextEditingController _descriptionField = TextEditingController();
  final List<String> _intervalTypeList = [
    'Daily',
    'Weekly',
  ];
  String? _selectedInterval;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? finalSelectedTime;
  Habits habitsList = boxHabits.getAt(0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('X'),
              Expanded(
                child: Text(
                  'Start a New Habit!',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const Text(
            'Habit Name',
          ),
          TextField(
            controller: _inputField,
          ),
          const Text('Description'),
          TextField(
            controller: _descriptionField,
          ),

          const Text('Interval'),
          SizedBox(
            // width: 200,
            child: DropdownButtonFormField(
              // itemHeight: 50,
              hint: Text('Select an option'),
              initialValue: _selectedInterval,
              items: _intervalTypeList
                  .map(
                    (String e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedInterval = newValue; // Update the selected value
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(), // Optional border decoration
              ),
            ),
          ),

          _selectedInterval == "Weekly" ? DayPicker() : SizedBox.shrink(),

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

          const Text('Icons'),
          TextButton(
            onPressed: () {
              setState(() {
                if (_selectedInterval != null &&
                    finalSelectedTime?.format(context) != null) {
                  boxHabits.put(
                    _inputField.text,
                    Habits(
                      name: _inputField.text,
                      interval: _selectedInterval!,
                      reminder: finalSelectedTime!.format(context),
                      description: _descriptionField.text,
                    ),
                  );
                }
              });
              // print('asa');
              // debugPrint(_inputField.text);
              // debugPrint(_descriptionField.text);
              // debugPrint(_selectedInterval);
              // debugPrint(finalSelectedTime?.format(context));
            },
            child: Text('Save'),
          ),
          Text(habitsList.name),
          if (habitsList.description != null)
            Text(habitsList.description ?? ""),
          Text(habitsList.interval),
          Text(habitsList.reminder),
        ],
      ),
    );
  }
}

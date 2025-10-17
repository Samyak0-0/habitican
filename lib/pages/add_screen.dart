import 'package:flutter/material.dart';
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
                // Optional label
                border: OutlineInputBorder(), // Optional border decoration
              ),
            ),
          ),

          ?_selectedInterval == "Weekly" ? DayPicker() : null,

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
              print('asa');
              print(_inputField.selection);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

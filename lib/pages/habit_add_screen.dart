import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/habits.dart';
import 'package:habitican/utils/day_picker.dart';
import 'package:habitican/utils/icon_list.dart';

class HabitAddScreen extends StatefulWidget {
  const HabitAddScreen({super.key});

  @override
  State<HabitAddScreen> createState() => _HabitAddScreenState();
}

class _HabitAddScreenState extends State<HabitAddScreen> {
  final TextEditingController _inputField = TextEditingController();
  final TextEditingController _descriptionField = TextEditingController();
  final List<String> _intervalTypeList = [
    'Daily',
    'Weekly',
  ];
  String? _selectedInterval;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay? finalSelectedTime;
  String? _selectedIcon;
  int newHabitId = (boxHabits.isEmpty)
      ? 1
      : boxHabits.values.map((h) => h.id).reduce((a, b) => a > b ? a : b) + 1;

  @override
  Widget build(BuildContext context) {
    // print(newHabitId);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Expanded(
              child: GridView.builder(
                itemCount: iconListSVG.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon != iconListSVG[index]
                              ? _selectedIcon = iconListSVG[index]
                              : _selectedIcon = null;
                        });
                      },
                      child: _selectedIcon != iconListSVG[index]
                          ? SvgPicture.asset(
                              "assets/icons/${iconListSVG[index]}",
                            )
                          : SvgPicture.asset(
                              "assets/icons/${iconListSVG[index]}",
                              colorFilter: const ColorFilter.mode(
                                Colors.red,
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (_selectedInterval != null &&
                      _inputField.text != "" &&
                      _selectedIcon != null) {
                    if (_selectedInterval == "Weekly") {}
                    boxHabits.put(
                      newHabitId,
                      Habits(
                        id: newHabitId,
                        name: _inputField.text,
                        interval: _selectedInterval!,
                        reminder: finalSelectedTime?.format(context),
                        iconName: _selectedIcon!,
                        description: _descriptionField.text,
                      ),
                    );
                    newHabitId += 1;
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

import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [],
          ),
          const Text(
            'Habit Name',
          ),
          const TextField(),
          const Text('Description'),
          const TextField(),
          const Text('Intervals'),
          const Text('Reminders'),
          const Text('Icons'),
          TextButton(
            onPressed: () {
              print('asa');
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

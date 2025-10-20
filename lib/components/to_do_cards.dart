import 'package:flutter/material.dart';
import 'package:habitican/pages/edit_screen.dart';

class ToDoCards extends StatelessWidget {
  final String name;
  final String? description;
  final String taskDateandReminder;
  const ToDoCards({
    super.key,
    required this.name,
    this.description,
    required this.taskDateandReminder,
  });

  @override
  Widget build(BuildContext context) {
    if (description != null) {
      return ListTile(
        title: Row(
          children: [Text(name), Text(taskDateandReminder)],
        ),
        subtitle: Text(description!),
        trailing: Icon(Icons.more_vert),
      );
    } else {
      return ListTile(
        title: Row(
          children: [Text(name), Text(taskDateandReminder)],
        ),
        trailing: PopupMenuButton(
          onSelected: (value) async {
            if (value == "edit") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return EditScreen();
                  },
                ),
              );
            }
            if (value == "delete") {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Task'),
                    content: Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Ok"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text("Edit"),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text("Delete"),
            ),
          ],
        ),
      );
    }
  }
}

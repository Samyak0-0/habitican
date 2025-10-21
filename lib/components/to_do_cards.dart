import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/pages/edit_screen.dart';

class ToDoCards extends StatefulWidget {
  final int id;
  final String name;
  final String? description;
  final String taskDateandReminder;
  const ToDoCards({
    super.key,
    required this.name,
    this.description,
    required this.taskDateandReminder,
    required this.id,
  });

  @override
  State<ToDoCards> createState() => _ToDoCardsState();
}

class _ToDoCardsState extends State<ToDoCards> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    Widget optionsForTasks = PopupMenuButton(
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
                      boxTasks.delete(widget.id);
                      // boxTasks.clear();
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
    );

    // if (description != null) {
    //   return ListTile(
    //     title: Row(
    //       children: [Text(name), Text(taskDateandReminder)],
    //     ),
    //     subtitle: Text(description!),
    //     trailing: Icon(Icons.more_vert),
    //   );
    // } else {

    return GestureDetector(
      onTap: () {
        setState(() {
          isCompleted = !isCompleted;
          // completedTasks
        });
      },
      child: ListTile(
        title: Row(
          children: [
            Text(
              widget.name,
              style: isCompleted
                  ? TextStyle(
                      color: Colors.green,
                    )
                  : TextStyle(),
            ),
            Text(widget.taskDateandReminder),
          ],
        ),
        trailing: optionsForTasks,
      ),
    );
  }
}

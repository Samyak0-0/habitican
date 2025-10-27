import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/tasks.dart';
import 'package:habitican/pages/edit_screen.dart';
import 'package:habitican/utils/daily_records_manager.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';

class ToDoCards extends StatefulWidget {
  final int id;
  final String name;
  final String? description;
  final String taskDateandReminder;
  final bool isCompleted;
  const ToDoCards({
    super.key,
    required this.name,
    this.description,
    required this.taskDateandReminder,
    required this.id,
    required this.isCompleted,
  });

  @override
  State<ToDoCards> createState() => _ToDoCardsState();
}

class _ToDoCardsState extends State<ToDoCards> {
  late Widget optionsForTasks = PopupMenuButton(
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

  @override
  Widget build(BuildContext context) {
    // if (description != null) {
    //   return ListTile(
    //     title: Row(
    //       children: [Text(name), Text(taskDateandReminder)],
    //     ),
    //     subtitle: Text(description!),
    //     trailing: Icon(Icons.more_vert),
    //   );
    // } else {
    if (widget.description != null) {
      return ListTile(
        title: Row(
          children: [
            Text(
              widget.name,
              style: widget.isCompleted
                  ? TextStyle(
                      // color: Colors.green,
                      decoration: TextDecoration.lineThrough,
                    )
                  : TextStyle(),
            ),
            Text(widget.taskDateandReminder),
          ],
        ),
        subtitle: Text(widget.description!),
        // leading: Icon,
        onTap: () {
          boxTasks.put(
            widget.id,
            Tasks(
              id: widget.id,
              name: widget.name,
              taskDateandReminder: widget.taskDateandReminder,
              isCompleted: !widget.isCompleted,
            ),
          );
          // boxDailyRecords.deleteAt(boxDailyRecords.length - 1);
          Provider.of<GlobalStateProvider>(
            context,
            listen: false,
          ).updateRecord(DateTime.now());
        },
        trailing: optionsForTasks,
      );
    }

    return ListTile(
      title: Row(
        children: [
          Text(
            widget.name,
            style: widget.isCompleted
                ? TextStyle(
                    // color: Colors.green,
                    decoration: TextDecoration.lineThrough,
                  )
                : TextStyle(),
          ),
          Text(widget.taskDateandReminder),
        ],
      ),

      onTap: () {
        boxTasks.put(
          widget.id,
          Tasks(
            id: widget.id,
            name: widget.name,
            taskDateandReminder: widget.taskDateandReminder,
            isCompleted: !widget.isCompleted,
          ),
        );
        // boxDailyRecords.deleteAt(boxDailyRecords.length - 1);
        Provider.of<GlobalStateProvider>(
          context,
          listen: false,
        ).updateRecord(DateTime.now());
      },
      trailing: optionsForTasks,
    );
  }
}

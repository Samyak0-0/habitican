import 'package:flutter/material.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/dailyTasks.dart';
import 'package:habitican/database/tasks.dart';
import 'package:habitican/pages/edit_screen.dart';
// import 'package:habitican/utils/daily_records_manager.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';

class ToDoDailyCards extends StatefulWidget {
  final int index;
  final int id;
  final String name;
  final String? description;
  final String Reminder;
  final bool isCompleted;
  const ToDoDailyCards({
    super.key,
    required this.name,
    this.description,
    required this.Reminder,
    required this.id,
    required this.isCompleted,
    required this.index,
  });

  @override
  State<ToDoDailyCards> createState() => _ToDoDailyCardsState();
}

class _ToDoDailyCardsState extends State<ToDoDailyCards> {
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
      if (value == "Make Task of the Day") {
        DailyTasks firstTask = boxDailyTasks.values.first;
        boxDailyTasks.put(
          0,
          DailyTasks(
            id: 0,
            name: widget.name,
            reminder: widget.Reminder,
            isCompleted: widget.isCompleted,
            description: widget.description,
          ),
        );
        // boxDailyTasks.add(firstTask);
        boxDailyTasks.put(
          widget.id,
          DailyTasks(
            id: widget.id,
            name: firstTask.name,
            reminder: firstTask.reminder,
            isCompleted: firstTask.isCompleted,
            description: firstTask.description,
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
                    boxDailyTasks.delete(widget.id);
                    // boxDailyTasks.clear();
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
        value: 'Make Task of the Day',
        child: Text("Make Task of the Day ⭐"),
      ),
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
    //       children: [Text(name), Text(Reminder)],
    //     ),
    //     subtitle: Text(description!),
    //     trailing: Icon(Icons.more_vert),
    //   );
    // } else {
    if (widget.description != null) {
      return ListTile(
        tileColor: (widget.index == 0 && widget.isCompleted == false)
            ? Colors.amberAccent
            : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Text(widget.Reminder.split("  ")[0]),
          ],
        ),
        subtitle: Text(widget.description!),
        // leading: Icon,
        onTap: () {
          boxDailyTasks.put(
            widget.id,
            DailyTasks(
              id: widget.id,
              name: widget.name,
              reminder: widget.Reminder,
              isCompleted: !widget.isCompleted,
            ),
          );
          // boxDailyRecords.deleteAt(boxDailyRecords.length - 1);
          // Update the daily record for the currently selected date so UI
          // components (like the calendar) refresh the correct day's progress.
          Provider.of<GlobalStateProvider>(
            context,
            listen: false,
          ).updateRecord(DateTime.now());
        },
        trailing: optionsForTasks,
      );
    }

    return ListTile(
      tileColor: (widget.index == 0 && widget.isCompleted == false)
          ? Colors.amberAccent
          : Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Text(widget.Reminder.split(" ")[0]),
        ],
      ),

      onTap: () {
        boxDailyTasks.put(
          widget.id,
          DailyTasks(
            id: widget.id,
            name: widget.name,
            reminder: widget.Reminder,
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

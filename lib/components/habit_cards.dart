import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitican/database/boxes.dart';
import 'package:habitican/database/habits.dart';
import 'package:habitican/pages/edit_screen.dart';
import 'package:habitican/utils/global_state_provider.dart';
import 'package:provider/provider.dart';

class Habitcards extends StatefulWidget {
  final int id;
  final String name;
  final String? description;
  final String interval;
  final String? reminder;
  final String habitIconName;
  final bool isCompleted;
  const Habitcards({
    super.key,
    required this.name,
    this.description,
    required this.interval,
    this.reminder,
    required this.habitIconName,
    required this.isCompleted,
    required this.id,
  });

  @override
  State<Habitcards> createState() => _HabitcardsState();
}

class _HabitcardsState extends State<Habitcards> {
  late Widget optionsForHabits = PopupMenuButton(
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
                    boxHabits.delete(widget.id);
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
    print(widget.id);
    // if (widget.description != "") {
    //   return ListTile(
    //     title: Text(
    //       widget.name,
    //       style: widget.isCompleted
    //           ? TextStyle(
    //               // color: Colors.green,
    //               decoration: TextDecoration.lineThrough,
    //             )
    //           : TextStyle(),
    //     ),
    //     // subtitle: Text(widget.description!),
    //     leading: SvgPicture.asset('assets/icons/${widget.habitIconName}'),
    //     trailing: optionsForHabits,
    //     onTap: () {
    //       boxHabits.put(
    //         widget.id,
    //         Habits(
    //           id: widget.id,
    //           name: widget.name,
    //           interval: widget.interval,
    //           iconName: widget.habitIconName,
    //           isCompleted: !widget.isCompleted,
    //         ),
    //       );
    //       Provider.of<GlobalStateProvider>(
    //         context,
    //         listen: false,
    //       ).updateRecord(DateTime.now());
    //     },
    //   );
    // } else {
    return ListTile(
      title: Text(
        widget.name,
        style: widget.isCompleted
            ? TextStyle(
                // color: Colors.green,
                decoration: TextDecoration.lineThrough,
              )
            : TextStyle(),
      ),
      leading: SvgPicture.asset('assets/icons/${widget.habitIconName}'),
      trailing: optionsForHabits,
      onTap: () {
        boxHabits.put(
          widget.id,
          Habits(
            id: widget.id,
            name: widget.name,
            interval: widget.interval,
            iconName: widget.habitIconName,
            isCompleted: !widget.isCompleted,
          ),
        );
        Provider.of<GlobalStateProvider>(
          context,
          listen: false,
        ).updateRecord(DateTime.now());
      },
    );
    // }
  }
}

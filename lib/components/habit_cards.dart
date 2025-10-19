import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Habitcards extends StatelessWidget {
  final String name;
  final String? description;
  final String interval;
  final String reminder;
  final String habitIconName;
  const Habitcards({
    super.key,
    required this.name,
    this.description,
    required this.interval,
    required this.reminder,
    required this.habitIconName,
  });

  @override
  Widget build(BuildContext context) {
    if (description != "") {
      return ListTile(
        title: Text(name),
        subtitle: Text(description!),
        leading: SvgPicture.asset('assets/icons/$habitIconName'),
        trailing: Icon(Icons.menu),
      );
    } else {
      return ListTile(
        title: Text(name),
        leading: SvgPicture.asset('assets/icons/$habitIconName'),
        trailing: Icon(Icons.menu),
      );
    }
  }
}

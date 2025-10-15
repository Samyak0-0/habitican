import 'package:flutter/material.dart';

class Habitcards extends StatelessWidget {
  final String name;
  const Habitcards({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      child: Text(name),
    );
  }
}

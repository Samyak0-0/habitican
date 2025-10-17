import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'habits.g.dart';

@HiveType(typeId: 1)
class Habits {
  Habits({
    required this.name,
    required this.interval,
    required this.reminder,
    this.description,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String interval;

  @HiveField(3)
  String reminder;
}

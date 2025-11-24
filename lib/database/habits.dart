import 'package:hive/hive.dart';

part 'habits.g.dart';

@HiveType(typeId: 1)
class Habits {
  Habits({
    required this.id,
    required this.name,
    required this.interval,
    required this.iconName,
    this.reminder,
    this.isCompleted = false,
    this.description,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String interval;

  @HiveField(4)
  String? reminder;

  @HiveField(5)
  String iconName;

  @HiveField(6)
  bool isCompleted;
}

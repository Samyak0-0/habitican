import 'package:hive/hive.dart';

part 'dailyTasks.g.dart';

@HiveType(typeId: 3)
class DailyTasks {
  DailyTasks({
    required this.id,
    required this.name,
    required this.reminder,
    this.description,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String reminder;
}

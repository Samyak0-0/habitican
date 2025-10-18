import 'package:hive/hive.dart';

part 'dailyTasks.g.dart';

@HiveType(typeId: 3)
class DailyTasks {
  DailyTasks({
    required this.name,
    required this.reminder,
    this.description,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String? description;

  @HiveField(3)
  String reminder;
}

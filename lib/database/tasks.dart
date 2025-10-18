import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 2)
class Tasks {
  Tasks({
    required this.name,
    required this.reminder,
    required this.interval,
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

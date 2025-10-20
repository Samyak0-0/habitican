import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 2)
class Tasks {
  Tasks({
    required this.id,
    required this.name,
    required this.reminder,
    required this.taskDate,
    this.description,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String taskDate;

  @HiveField(4)
  String reminder;
}

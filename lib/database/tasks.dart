import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 2)
class Tasks {
  Tasks({
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

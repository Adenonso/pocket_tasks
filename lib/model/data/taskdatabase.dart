import 'package:hive/hive.dart';
import 'package:pocket_tasks/model/data/sub_tasksdatabase.dart';
part 'taskdatabase.g.dart';

@HiveType(typeId: 1)
class Taskdatabase {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? myNotes = '';

  @HiveField(2)
  List<SubTasksdatabase> noteContents;

  @HiveField(3)
  bool? isCompleted;

  @HiveField(4)
  DateTime? createdAt;

  Taskdatabase(
      {required this.title,
      required this.noteContents,
      this.createdAt,
      this.isCompleted,
      this.myNotes = ''});
}

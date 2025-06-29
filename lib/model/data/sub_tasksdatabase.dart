import 'package:hive/hive.dart';
part 'sub_tasksdatabase.g.dart';

@HiveType(typeId: 0)
class SubTasksdatabase {
  @HiveField(0)
  String note;

  // @HiveField(1)
  // bool isCompleted = false;

  SubTasksdatabase({
    required this.note,
  });
}

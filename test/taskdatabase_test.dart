import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/model/data/taskdatabase.dart';
import 'package:pocket_tasks/model/data/sub_tasksdatabase.dart';

taskdatabaseTest() {
  group('Taskdatabase', () {
    test('should instantiate with required fields', () {
      final subTasks = <SubTasksdatabase>[];
      final task = Taskdatabase(title: 'Test', noteContents: subTasks);
      expect(task.title, 'Test');
      expect(task.noteContents, subTasks);
      expect(task.isCompleted, isNull);
      expect(task.myNotes, '');
    });
  });
}

void main() {
  taskdatabaseTest();
}

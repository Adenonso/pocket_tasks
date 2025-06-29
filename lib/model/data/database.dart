import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_tasks/model/data/taskdatabase.dart';
import 'package:pocket_tasks/model/data/sub_tasksdatabase.dart';

class Database {
  // List subtasks = [];

  final Box<Taskdatabase> _taskBox = Hive.box<Taskdatabase>('taskBox');
  final Box<SubTasksdatabase> _subtaskBox =
      Hive.box<SubTasksdatabase>('subtaskBox');

  List<Taskdatabase> getTasks() {
    return _taskBox.values.toList();
  }

  //add task
  void addTask(Taskdatabase tasks) {
    _taskBox.add(tasks);
  }

  //update the taskdatabase
  void updateTaskdatabase(int index, Taskdatabase tasks) {
    _taskBox.put(index, tasks);
  }

  //delete task
  void deleteTask(int index) {
    _taskBox.delete(index);
  }

  void addNote(int index, String note) {
    final task = _taskBox.get(index);
    if (task != null) {
      task.myNotes = note;
      _taskBox.put(index, task);
    }
  }

  //the subtask is for a case where a list of subtasks wants to be added to a specific task
  //I initially made use of lists, then later replaced it with note (since this was specified)
  //add subtask note
  void addSubTask(Taskdatabase task, SubTasksdatabase subtask) {
    final newSubTask = SubTasksdatabase(note: subtask.note);
    task.noteContents.add(newSubTask);
  }

  void updateSubTask(
      Taskdatabase task, int taskIndex, SubTasksdatabase subTask) {
    task.noteContents[taskIndex] = subTask;
    _subtaskBox.putAt(_subtaskBox.values.toList().indexOf(subTask), subTask);
  }
}

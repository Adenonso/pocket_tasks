import 'package:flutter/material.dart';
import 'package:pocket_tasks/model/data/database.dart';
import 'package:pocket_tasks/model/data/taskdatabase.dart';

class TaskProvider extends ChangeNotifier {
  final Database taskDb = Database();

  List<Taskdatabase> get tasks => taskDb.getTasks();

  void addTask(Taskdatabase task) {
    taskDb.addTask(task);
    notifyListeners();
  }

  void deleteTask(int index, Taskdatabase task) {
    taskDb.deleteTask(index);
    notifyListeners();
  }

  // void addSubTask(Taskdatabase task, SubTasksdatabase subtask) {
  //   taskDb.addSubTask(task, subtask);
  //   notifyListeners();
  // }

  void addNotes(int index, String note) {
    taskDb.addNote(index, note);
    notifyListeners();
  }
}

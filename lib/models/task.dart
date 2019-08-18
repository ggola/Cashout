import 'package:flutter/foundation.dart';
import 'dart:collection';

final String tableTodo = 'tasks';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

// Task model
class Task {
  int id;
  String name;
  bool isDone;

  Task({this.id, this.name, this.isDone = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: name,
      columnDone: isDone == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnTitle];
    isDone = (map[columnDone] == 1) ? true : false;
  }
}

// Change listener
class TaskList extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addSavedTasks(List<Task> savedTasks) {
    _tasks = savedTasks;
    notifyListeners();
  }

  void addTask({String title, int id}) {
    _tasks.add(Task(name: title, id: id));
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateToggleDone(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  int activeTasks = 0;

  void countActiveTasks(int activeTasksSaved) {
    activeTasks = activeTasksSaved;
    notifyListeners();
  }

  void updateActiveTasks({bool checkBoxState}) {
    activeTasks = checkBoxState ? activeTasks - 1 : activeTasks + 1;
    notifyListeners();
  }
}

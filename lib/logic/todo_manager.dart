import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart';

class TaskProvider with ChangeNotifier {
  final List<ElementTask> _tasks = dummyData;

  List<ElementTask> get tasks => [..._tasks];

  void addTask(ElementTask task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(int index, ElementTask updatedTask) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void toggleTaskStatus(int index) {
    if (index >= 0 && index < _tasks.length) {
      final task = _tasks[index];
      _tasks[index] = ElementTask(
        name: task.name,
        urgencyLevel: task.urgencyLevel,
        color: task.color,
        isPending: !task.isPending,
        startTime: task.startTime,
        absoluteDeadline: task.absoluteDeadline,
        desireDeadline: task.desireDeadline,
        category: task.category,
      );
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/home/home_screen.dart';

class TaskProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _categories = dummyData;

  List<Map<String, dynamic>> get categories => _categories;

  void toggleTaskDone(String categoryTitle, int taskIndex) {
    final task =
        _categories.firstWhere(
          (element) => element['title'] == categoryTitle,
        )['tasks'][taskIndex];
    task.isDone = !task.isDone;
    notifyListeners();
  }

  void deleteTask(String categoryTitle, int taskIndex) {
    _categories
        .firstWhere((element) => element['title'] == categoryTitle)['tasks']
        .removeAt(taskIndex);
    notifyListeners();
  }

  void updateTask(
    String categoryTitle,
    int taskIndex,
    ElementTask updatedTask,
  ) {
    _categories.firstWhere(
          (element) => element['title'] == categoryTitle,
        )['tasks'][taskIndex] =
        updatedTask;
    notifyListeners();
  }

  void addTaskToCategory(String categoryTitle, ElementTask task) {
    final category = _categories.firstWhere(
      (element) => element['title'] == categoryTitle,
      orElse: () => throw Exception("Category not found"),
    );
    (category['tasks'] as List<ElementTask>).add(task);
    notifyListeners();
  }
}

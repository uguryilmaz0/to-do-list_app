import 'package:flutter/material.dart';

class Task {
  String name;
  String description;
  String startDate;
  String endDate;

  Task({required this.name, required this.description, required this.startDate, required this.endDate});
}

class TaskList extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }
}

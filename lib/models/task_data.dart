import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class TaskData extends ChangeNotifier {
  TaskFilter currentFilter = TaskFilter.All;
  List<Task> tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy eggs'),
    Task(name: 'Buy bread'),
  ];

  List<Task> completedTasks = []; // Added completedTasks list
  List<Task> removedTasks = []; // Added removedTasks list

  void addTask(String newTaskTitle) {
    tasks.add(Task(name: newTaskTitle));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.doneChange();
    if (task.isDone) {
      task.completionDate = DateTime.now(); // Set the completion date
      completedTasks.add(task); // Move completed task to completedTasks list
    } else {
      task.completionDate = null; // Clear the completion date
      completedTasks.remove(task); // Remove from completedTasks if not done
    }
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    task.removalDate = DateTime.now(); // Set the removal date
    removedTasks.add(task);
    notifyListeners();
  }

  void restoreTask(Task task) {
    tasks.add(task); // Restore task to tasks list
    removedTasks.remove(task);
    notifyListeners();
  }
}

enum TaskFilter {
  All,
  Done,
  Undone,
}

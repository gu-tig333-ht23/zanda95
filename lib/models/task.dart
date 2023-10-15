import 'package:flutter/material.dart';
import '../models/api.dart';

// Task class represents individual tasks with a name, checkbox status, and ID
class Task {
  final String tName; // Task name
  bool isCompleted; // Checkbox status
  final String? id; // Unique identifier for the task

  Task(
    this.tName, {
    this.isCompleted = false, // Default checkbox status is false (unchecked)
    this.id,
  });

  // Factory constructor to create a Task object from JSON data
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(json['title'], isCompleted: json['done'], id: json['id']);
  }

  // Method to convert Task object to JSON format
  Map<String, dynamic> toJson() {
    return {"title": tName, 'done': isCompleted};
  }
}

// ToDoTask class extends ChangeNotifier to manage the task list and provide state management
class ToDoTask extends ChangeNotifier {
// List to store tasks
  List<Task> tasks = [];

// Method to fetch the task list from the API
  void fetchList() async {
    var filteredTasks = await API.getList(); // Get tasks from the API
    tasks = filteredTasks; // Update the task list
    notifyListeners(); // Notify listeners to update the UI
  }

  API apiMethods = API(); // Instance of API class to perform API operations

  // Method to toggle the checkbox status of a task
  void checkBoxChanged(task) async {
    Task updatedTask = task;
    updatedTask.isCompleted = !updatedTask.isCompleted;
    await apiMethods.updateTask(task);
    fetchList();
  }

// Method to add a new task
  void saveNewTask(task) async {
    Task newTask = Task(task);
    await apiMethods.addTask(newTask);
    fetchList();
  }

  // Method to delete a task
  void deleteTask(task) async {
    await apiMethods.removeTask(task);
    fetchList();
  }

// Filter for tasks (All, Done, Undone)
  String selectedFilter = '';

  String setFilter(String filt) {
    selectedFilter = filt;
    notifyListeners();
    return selectedFilter;
  }

// Method to get the filtered task list based on the selected filter
  List<Task> get filteredTasks {
    switch (selectedFilter) {
      case 'all':
        return tasks.toList();
      case 'done':
        return tasks.where((element) => element.isCompleted == true).toList();
      case 'undone':
        return tasks.where((element) => element.isCompleted == false).toList();
      default:
        return tasks.toList();
    }
  }
}

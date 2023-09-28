import 'package:flutter/material.dart';
import 'package:todo/api.dart';
import 'package:todo/models/task.dart';

class TaskData extends ChangeNotifier {
  TaskFilter currentFilter = TaskFilter.All;
  List<Task> tasks = [];
  List<Task> completedTasks = [];
  List<Task> removedTasks = [];

  TaskData([List<Note>? notes])
      : tasks = notes != null
            ? notes
                .map((note) => Task(
                      id: note.id,
                      name: note.title,
                      done: note.done,
                    ))
                .toList()
            : [];

  Future<void> addTask(String newTaskTitle) async {
    final newTask = Task(id: UniqueKey().toString(), name: newTaskTitle);

    // Add the new task to the local tasks list
    tasks.add(newTask);

    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    task.done = !task.done;

    // Update the task in the API
    await updateTaskInAPI(task, task.done);

    if (task.done) {
      task.completionDate = DateTime.now();
      completedTasks.add(task);
    } else {
      task.completionDate = null;
      completedTasks.remove(task);
    }

    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    task.removalDate = DateTime.now(); // Set the removal date
    removedTasks.add(task);

    // Call the removeTaskInAPI function to remove the task from the API
    removeTaskInAPI(task);

    notifyListeners();
  }

  void restoreTask(Task task) {
    tasks.add(task);
    removedTasks.remove(task);
    notifyListeners();
  }
}

enum TaskFilter {
  All,
  Done,
  Undone,
}

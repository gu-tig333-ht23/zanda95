import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';

class TasksList extends StatelessWidget {
  final List<Task>? tasks;

  TasksList({this.tasks});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        final tasksToDisplay = tasks ?? taskData.tasks;
        return ListView.builder(
          itemCount: tasksToDisplay.length,
          itemBuilder: (context, index) {
            final task = tasksToDisplay[index];
            return TaskTile(
              isChecked: task.done,
              taskTitle: task.name,
              completionDate: task.completionDate,
              checkboxChange: (newValue) {
                taskData.updateTask(task);
              },
              listTileDelete: () {
                taskData.deleteTask(task);
              },
              task: task, // Pass the 'task' parameter here
            );
          },
        );
      },
    );
  }
}

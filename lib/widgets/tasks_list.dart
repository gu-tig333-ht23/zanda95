import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';

class TasksList extends StatelessWidget {
  final List<Task>? tasks; // Make tasks an optional parameter

  TasksList({this.tasks}); // Update the constructor

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        final tasksToDisplay = tasks ??
            taskData
                .tasks; // Use tasks if provided, otherwise use taskData.tasks
        return ListView.builder(
          itemCount: tasksToDisplay.length,
          itemBuilder: (context, index) {
            return TaskTile(
              isChecked: tasksToDisplay[index].isDone,
              taskTitle: tasksToDisplay[index].name,
              completionDate: tasksToDisplay[index].completionDate,
              checkboxChange: (newValue) {
                taskData.updateTask(tasksToDisplay[index]);
              },
              listTileDelete: () {
                taskData.deleteTask(tasksToDisplay[index]);
              },
            );
          },
        );
      },
    );
  }
}

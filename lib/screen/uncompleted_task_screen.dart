import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/widgets/task_tile.dart';

class UncompletedTasksScreen extends StatelessWidget {
  const UncompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uncompleted Tasks'),
      ),
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          final uncompletedTasks =
              taskData.tasks.where((task) => !task.isDone).toList();

          if (uncompletedTasks.isEmpty) {
            return Center(
              child: Text('No uncompleted tasks.'),
            );
          }

          return ListView.builder(
            itemCount: uncompletedTasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                isChecked: false,
                taskTitle: uncompletedTasks[index].name,
                completionDate: uncompletedTasks[index]
                    .completionDate, // Pass completionDate
                checkboxChange: (newValue) {
                  taskData.updateTask(uncompletedTasks[index]);
                },
                listTileDelete: () {
                  // Optionally, you can implement a delete action for uncompleted tasks
                  // taskData.deleteTask(uncompletedTasks[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}

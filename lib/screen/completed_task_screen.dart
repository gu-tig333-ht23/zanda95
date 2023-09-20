import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/widgets/task_tile.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
      ),
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          final completedTasks =
              taskData.tasks.where((task) => task.isDone).toList();

          if (completedTasks.isEmpty) {
            return Center(
              child: Text('No completed tasks yet.'),
            );
          }

          return ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                isChecked: true,
                taskTitle: completedTasks[index].name,
                completionDate:
                    completedTasks[index].completionDate, // Pass completionDate
                checkboxChange: (_) {},
                listTileDelete: () {
                  // Optionally, you can implement a delete action for completed tasks
                  // taskData.deleteTask(completedTasks[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}

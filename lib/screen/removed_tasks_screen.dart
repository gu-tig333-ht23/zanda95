import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/widgets/task_tile.dart';

class RemovedTasksScreen extends StatelessWidget {
  const RemovedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Removed Tasks'),
      ),
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          final removedTasks = taskData.removedTasks;

          if (removedTasks.isEmpty) {
            return Center(
              child: Text('No removed tasks yet.'),
            );
          }

          return ListView.builder(
            itemCount: removedTasks.length,
            itemBuilder: (context, index) {
              final removedTask = removedTasks[index];
              final removalDate = removedTask.removalDate;
              final formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(removalDate!);

              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      removedTask.name,
                      style: TextStyle(
                        decoration: removedTask.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    if (removalDate != null)
                      Text(
                        'Removed on $formattedDate',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore), // Use the "restore" icon
                  color: Colors.green, // Set the icon color as desired
                  onPressed: () {
                    // Implement the restore action for removed tasks
                    taskData.restoreTask(removedTask);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

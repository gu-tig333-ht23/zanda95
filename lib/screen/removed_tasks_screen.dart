import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';

class RemovedTasksScreen extends StatelessWidget {
  const RemovedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
            decoration: BoxDecoration(
              color: Color(0xFF674AEF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Align children to the start and end
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Removed Tasks', // Updated title
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.info_outline,
                      color: Colors.white), // Add an info icon here
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      title: 'Important',
                      desc:
                          'Please be aware that when tasks are removed, they are permanently deleted from the database. This data cannot be restored due to the limitations of the APIs structure.',
                      btnOkOnPress: () {},
                    )..show();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskData>(
              builder: (context, taskData, child) {
                final removedTasks = taskData.removedTasks;
                if (removedTasks.isEmpty) {
                  return Center(
                    child: Text('No removed tasks yet.'),
                  );
                } else {
                  // Your ListView.builder code goes here
                  return ListView.builder(
                    itemCount: removedTasks.length,
                    itemBuilder: (context, index) {
                      final removedTask = removedTasks[index];
                      final removalDate = removedTask.removalDate;
                      final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(removalDate!);

                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              removedTask.name,
                              style: TextStyle(
                                decoration: removedTask.done
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            // ignore: unnecessary_null_comparison
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

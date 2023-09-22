import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/api.dart';
import 'package:todo/models/task.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final DateTime? completionDate;
  final void Function(bool?) checkboxChange;
  final void Function() listTileDelete;
  final Task task; // Add a parameter to store the task

  TaskTile({
    required this.isChecked,
    required this.taskTitle,
    required this.completionDate,
    required this.checkboxChange,
    required this.listTileDelete,
    required this.task, // Add a required parameter for the task
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskTitle,
            style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
          if (completionDate != null)
            Text(
              'Completed on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(completionDate!)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon:
                Icon(Icons.delete, color: Colors.red), // Add an info icon here
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: 'Important',
                desc: 'Are you sure you want to delete this task permanently?',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  listTileDelete();
                },
              ).show();
            },
          ),
          Checkbox(
            activeColor: Colors.teal[400],
            value: isChecked,
            onChanged: (newValue) async {
              // Update the local task immediately
              checkboxChange(newValue);

              // Then, update the API by calling the updateTaskInAPI function
              if (newValue != null) {
                await updateTaskInAPI(task, newValue);
              }
            },
          ),
        ],
      ),
      onLongPress: listTileDelete,
    );
  }
}

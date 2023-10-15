import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';
import '../models/task.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// Task Tile Widget to display individual tasks in the list
class ToDoTile extends StatelessWidget {
  final Task task;

// Constructor to initialize the task property
  const ToDoTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final toDoTask = context.watch<ToDoTask>();

    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Checkbox to mark task as done or undone
            GestureDetector(
              onTap: () {
                toDoTask.checkBoxChanged(task);
              },
              child: !task.isCompleted // CHECKBOX DESIGN
                  ? const Icon(
                      Icons.radio_button_unchecked,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.check_circle,
                      color: primaryColor,
                    ),
            ),
            // Task name
            // Expanded widget to make the text take up as much space as possible
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  task.tName,
                  style: TextStyle(
                    color: task.isCompleted
                        ? primaryColor
                        : Color.fromARGB(255, 61, 56, 56),
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
            // Delete Button
            // Container to add a border around the icon
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  // Display confirmation dialog before deleting the task
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title:
                        'Are you sure you want to delete this task permanently?',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      toDoTask.deleteTask(task);
                    },
                  ).show();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

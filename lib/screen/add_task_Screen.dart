import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/api.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTaskCallback;

  AddTaskScreen(this.addTaskCallback);

  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.teal[400],
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskTitle = newText; // Capture the text input from the user
            },
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              // Create a new task object
              Task newTask = Task(name: newTaskTitle ?? '', id: '');

              // Save the task to the API
              await saveTaskToAPI(newTask);

              // Notify the task list to update
              Provider.of<TaskData>(context, listen: false)
                  .addTask(newTaskTitle ?? '');
              Navigator.pop(context);
            },
            child: Text(
              'Add',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.teal[400]),
          ),
        ],
      ),
    );
  }
}

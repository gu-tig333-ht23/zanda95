import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';

// TaskStatusFilter class provides a dialog with filter options for tasks
class TaskStatusFilter extends StatelessWidget {
  const TaskStatusFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //FILTER ALL
          ElevatedButton(
            onPressed: () {
              context.watch<ToDoTask>().setFilter('all');
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              minimumSize: Size(100, 0),
              padding: EdgeInsets.symmetric(vertical: 16),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text("All"),
          ),
          SizedBox(height: 4),

          // Filter button for Done tasks
          ElevatedButton(
            onPressed: () {
              context.watch<ToDoTask>().setFilter('done');
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              minimumSize: Size(100, 0),
              padding: EdgeInsets.symmetric(vertical: 16),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text("Done"),
          ),
          SizedBox(height: 4),

          // Filter button for Undone tasks
          ElevatedButton(
            onPressed: () {
              context.watch<ToDoTask>().setFilter('undone');
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              minimumSize: Size(100, 0),
              padding: EdgeInsets.symmetric(vertical: 16),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text("Undone"),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}

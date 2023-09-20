import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final DateTime? completionDate; // Add completionDate property
  final void Function(bool?) checkboxChange;
  final void Function() listTileDelete;

  TaskTile({
    required this.isChecked,
    required this.taskTitle,
    required this.completionDate,
    required this.checkboxChange,
    required this.listTileDelete,
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
          if (completionDate != null) // Display completion date if it exists
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
          GestureDetector(
            onTap: listTileDelete,
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          Checkbox(
            activeColor: Colors.teal[400],
            value: isChecked,
            onChanged: checkboxChange,
          ),
        ],
      ),
      onLongPress: listTileDelete,
    );
  }
}

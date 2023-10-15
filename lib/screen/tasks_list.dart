import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/task_tile.dart';
import '../models/task.dart';

// ViewMyList class displays the list of tasks using ToDoTile widget
class ViewMyList extends StatelessWidget {
  // Consumer widget to listen to changes in the task list
  const ViewMyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoTask>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value
            .filteredTasks.length, // to get the number of tasks in the list
        itemBuilder: (context, index) {
          return ToDoTile(
            task: value.filteredTasks[
                index], // Passing individual task to ToDoTile widget
          );
        },
      ),
    );
  }
}

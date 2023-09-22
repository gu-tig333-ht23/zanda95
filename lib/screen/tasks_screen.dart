import 'package:flutter/material.dart';
import 'package:todo/api.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/screen/add_task_screen.dart';
import 'package:todo/widgets/tasks_list.dart';
import 'package:provider/provider.dart';
import 'completed_task_screen.dart';
import 'uncompleted_task_screen.dart';
import 'removed_tasks_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);

    // Filter tasks based on search text
    final filteredTasks = taskData.tasks
        .where((task) =>
            task.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${taskData.tasks.length} Tasks',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return PopupMenuButton<String>(
                          onSelected: (value) {
                            // Handle menu item selection here
                            if (value == 'All') {
                              getNotes();
                              // Navigate to TasksScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TasksScreen(),
                                ),
                              );
                            } else if (value == 'Done') {
                              // Navigate to CompletedTasksScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompletedTasksScreen(),
                                ),
                              );
                            } else if (value == 'Undone') {
                              // Navigate to UncompletedTasksScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UncompletedTasksScreen(),
                                ),
                              );
                            } else if (value == 'Removed') {
                              // Navigate to RemovedTasksScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RemovedTasksScreen(),
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return ['All', 'Done', 'Undone', 'Removed']
                                .map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search your task...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14, // Adjust vertical padding as needed
                      ),
                      // Center the hint text vertically
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: TasksList(
                tasks: filteredTasks,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddTaskScreen((newTaskTitle) {}),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 223, 67, 6),
      ),
    );
  }
}

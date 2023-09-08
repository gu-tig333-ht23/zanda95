import 'package:flutter/material.dart';
import 'new_task_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Updated color
        title: Text(
          'To-Do List',
          style: TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Filter button functionality
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    content: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          FilterRow(Icons.check_box_outline_blank, 'All'),
                          FilterRow(Icons.check_box_outline_blank, 'Done'),
                          FilterRow(Icons.check_box_outline_blank, 'Undone'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: ListViewBuilder(), // Task list
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor:
            const Color.fromARGB(255, 64, 153, 255), // Updated color
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTask()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskItem {
  String task;
  bool completed;

  TaskItem(this.task, this.completed);
}

class ListViewBuilder extends StatefulWidget {
  ListViewBuilder({Key? key}) : super(key: key);

  @override
  ListViewBuilderState createState() => ListViewBuilderState();
}

class ListViewBuilderState extends State<ListViewBuilder> {
  List<TaskItem> tasks = [
    TaskItem("Workout", false),
    TaskItem("TV", false),
    TaskItem("Study", false),
    TaskItem("Sleep", false),
    TaskItem("Eat", false),
    TaskItem("Code", false),
    TaskItem("Read", false),
    TaskItem("Cook", false),
    TaskItem("Clean", false),
    TaskItem("Walk", false),
    TaskItem("Run", false),
    TaskItem("Swim", false),
    TaskItem("Shop", false),
    TaskItem("Play", false),
    TaskItem("Sing", false),
    TaskItem("Dance", false),
    TaskItem("Drive", false),
    TaskItem("Fly", false),
    TaskItem("Travel", false),
    TaskItem("Write", false),
    TaskItem("Draw", false),
    TaskItem("Paint", false),
    TaskItem("Design", false),
    TaskItem("Build", false),
    TaskItem("Create", false),
    TaskItem("Learn", false),
    TaskItem("Teach", false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(9),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      tasks[index].task,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: tasks[index].completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: tasks[index].completed,
                    onChanged: (bool? value) {
                      setState(() {
                        tasks[index].completed = value!;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FilterRow extends StatelessWidget {
  final IconData icon;
  final String text;

  FilterRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

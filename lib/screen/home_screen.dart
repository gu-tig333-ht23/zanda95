import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screen/add_task_Screen.dart';
import 'package:todo/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  // State variable to store the search text entered by the user
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    // Accessing the state of the ToDoTask class
    final todoProvider = Provider.of<ToDoTask>(context);

    // Filter tasks based on search text
    final filteredTasks = todoProvider.filteredTasks
        .where((task) =>
            task.tName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
        body: Column(
          children: [
            // Header section with task count, search bar and filter button
            Container(
              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
              decoration: BoxDecoration(
                color: primaryColor,
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
                      // Displaying the total number of tasks
                      Text(
                        '${todoProvider.filteredTasks.length} Tasks',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Filter menu button
                      Builder(
                        builder: (BuildContext context) {
                          return PopupMenuButton<String>(
                            onSelected: (value) {
                              // Handle menu item selection here
                              if (value == 'All') {
                                todoProvider.setFilter('all');
                              } else if (value == 'Done') {
                                todoProvider.setFilter('done');
                              } else if (value == 'Undone') {
                                todoProvider.setFilter('undone');
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                {
                                  'label': 'All',
                                  'icon': Icons.all_inclusive_outlined,
                                  'color': Colors.teal,
                                },
                                {
                                  'label': 'Done',
                                  'icon': Icons.check_circle,
                                  'color': primaryColor,
                                },
                                {
                                  'label': 'Undone',
                                  'icon': Icons.radio_button_unchecked,
                                  'color': Colors.grey,
                                },
                              ].map((Map<String, dynamic> choice) {
                                return PopupMenuItem<String>(
                                  value: choice['label'],
                                  child: Row(
                                    children: [
                                      Icon(choice['icon'],
                                          color: choice['color']),

                                      SizedBox(
                                          width:
                                              12), // Adding some space between icon and text
                                      Text(choice['label']),
                                    ],
                                  ),
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
                  SizedBox(height: 5),
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
                          vertical: 14,
                        ),
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1),
            // List of tasks displayed based on the applied filters and search text
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    return ToDoTile(task: filteredTasks[index]);
                  },
                ),
              ),
            ),
          ],
        ),
        // Floating action button to add a new task
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show the add task dialog when the button is pressed
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              AddTask(), // Assuming AddTask is a widget for adding a task
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          backgroundColor: primaryColor,
          child: Icon(Icons.post_add),
        ));
  }
}

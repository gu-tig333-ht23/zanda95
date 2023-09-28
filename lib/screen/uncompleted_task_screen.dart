import 'package:flutter/material.dart';
import 'package:todo/api.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/tasks_list.dart';

class UncompletedTasksScreen extends StatefulWidget {
  @override
  _UncompletedTasksScreenState createState() => _UncompletedTasksScreenState();
}

class _UncompletedTasksScreenState extends State<UncompletedTasksScreen> {
  String searchText = '';

  Future<List<Task>> _fetchUncompletedTasks() async {
    // Use your API method to fetch uncompleted tasks
    final uncompletedTasks =
        await fetchUncompletedTasksFromAPI(); // Replace with your API call
    return uncompletedTasks;
  }

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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Uncompleted Tasks',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                      hintText: 'Search uncompleted tasks...',
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
          FutureBuilder<List<Task>>(
            future: _fetchUncompletedTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 350), // Add padding as needed
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center vertically
                      children: [
                        Text(
                          'No uncompleted tasks.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20, // Adjust the font size as desired
                            fontWeight:
                                FontWeight.bold, // Add bold style if preferred
                            color: Colors.grey, // Customize the text color
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                final uncompletedTasks = snapshot.data!;
                final filteredUncompletedTasks = uncompletedTasks
                    .where((task) => task.name
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    .toList();
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: TasksList(
                      tasks: filteredUncompletedTasks,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

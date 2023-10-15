// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screen/home_screen.dart';

// Primary color for the app
const Color primaryColor = Color(0xFF674AEF);

void main() {
  // Creating an instance of ToDoTask class
  ToDoTask state = ToDoTask();

  // Fetching the task list from the API
  state.fetchList();

  // Running the app with ChangeNotifierProvider to manage the state
  runApp(ChangeNotifierProvider(
    create: (context) => state,
    child: const MyApp(),
  ));
}

// MyApp class, the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Setting the home page to HomePage widget
    );
  }
}

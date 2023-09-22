import 'package:flutter/material.dart';
import 'package:todo/api.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/screen/tasks_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  List<Note> notes = await getNotes();
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          TaskData(notes), // Pass the fetched notes to TaskData
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}

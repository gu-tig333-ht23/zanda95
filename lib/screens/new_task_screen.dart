import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  //Class for adding new task
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 64, 153, 255),
        title: Text(
          'Write a new task',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              // Creating textfield
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a new task!'),
            ),
          ),
          ElevatedButton(
            // Add task button
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 64, 153, 255),
            ),
            child: Text(
              'Add Task',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}

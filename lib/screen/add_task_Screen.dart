import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';

// Widget for adding a new task to the list
class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);

// Controller for the task input field
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(40),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              // Textfield for entering the task
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter your task here...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Button color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("CANCEL"),
                  ),
                  // Add task button to add the task to the list
                  Consumer<ToDoTask>(
                    builder: (context, value, child) => ElevatedButton(
                      onPressed: () {
                        String enteredText = _controller.text;

                        if (enteredText.isEmpty) {
                          // Show error dialog if the textfield is empty
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.topSlide,
                            showCloseIcon: true,
                            title: 'Textfield empty! Please insert a task.',
                            btnOkColor: Colors.red,
                            btnOkOnPress: () {},
                          ).show();
                        } else {
                          // Save the new task and show success dialog
                          value.saveNewTask(enteredText);
                          _controller.clear();
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            title:
                                'Your task has been added to the list successfully!',
                            btnOkOnPress: () {
                              Navigator.of(context).pop();
                            },
                          ).show();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, // Button color
                        foregroundColor: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("ADD TASK"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

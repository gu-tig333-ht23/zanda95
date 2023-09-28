import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/models/task.dart';

const String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
const String API_KEY = '70653ae4-4764-4f39-a8d5-fe8b6706ab0c';

class Note {
  final String id;
  final String title;
  final bool done;

  Note(this.id, this.title, this.done);
}

Future<List<Note>> getNotes() async {
  print('Making request to API to get todos');

  // Define the API endpoint for getting todos with your API key
  final apiTodosEndpoint = Uri.parse('$ENDPOINT/todos?key=$API_KEY');

  try {
    http.Response response = await http.get(apiTodosEndpoint);

    // Check if the response status code is successful (usually 200)
    if (response.statusCode == 200) {
      // Parse the JSON response body into a list of notes
      List<dynamic> data = json.decode(response.body);
      List<Note> todos = data.map((item) {
        // Check if 'id', 'title', and 'done' keys are not null before using them
        return Note(
          item['id'] as String? ?? '', // Provide a default value for null
          item['title'] as String? ?? '', // Provide a default value for null
          item['done'] as bool? ?? false, // Provide a default value for null
        );
      }).toList();
      return todos;
    } else {
      // Handle non-successful status codes (e.g., 404, 500, etc.) here
      print('Failed to get todos. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    print('An error occurred: $e');
    return [];
  }
}

Future<http.Response> saveTaskToAPI(Task task) async {
  try {
    final apiEndpoint = Uri.parse('$ENDPOINT/todos?key=$API_KEY');

    final response = await http.post(
      apiEndpoint,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "title": task.name,
        "done": false,
      }),
    );

    if (response.statusCode == 200) {
      return response; // Return the HTTP response if successful
    } else {
      // Handle non-successful status codes (e.g., 404, 500, etc.) here
      print('Failed to add task to API. Status code: ${response.statusCode}');
      throw Exception('Failed to add task to API');
    }
  } catch (e) {
    print("An error occurred while adding the task to the API: $e");
    throw Exception('An error occurred while adding the task to the API');
  }
}

Future<void> updateTaskInAPI(Task task, bool done) async {
  try {
    final apiEndpoint = Uri.parse('$ENDPOINT/todos/${task.id}?key=$API_KEY');

    final response = await http.put(
      apiEndpoint,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "title": task.name, // Include the title when updating the task
        "done": done, // Use the updated done status
      }),
    );

    if (response.statusCode == 200) {
      print("Task updated in API successfully.");
    } else {
      print(
          "Failed to update task in API. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred while updating the task in the API: $e");
  }
}

Future<void> removeTaskInAPI(Task task) async {
  try {
    final apiEndpoint = Uri.parse('$ENDPOINT/todos/${task.id}?key=$API_KEY');

    final response = await http.delete(
      apiEndpoint,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print("Task removed from API successfully.");
    } else {
      print(
          "Failed to remove task from API. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred while removing the task from the API: $e");
  }
}

Future<List<Task>> fetchCompletedTasksFromAPI() async {
  print('Fetching completed tasks from API');

  try {
    final apiEndpoint = Uri.parse('$ENDPOINT/todos?key=$API_KEY');

    final response = await http.get(apiEndpoint);

    if (response.statusCode == 200) {
      // Parse the JSON response body into a list of tasks
      List<dynamic> data = json.decode(response.body);
      List<Task> completedTasks = [];

      for (var item in data) {
        if (item['done'] == true) {
          completedTasks.add(Task(
            id: item['id'] as String? ?? '',
            name: item['title'] as String? ?? '',
            done: item['done'] as bool? ?? false,
            // Add other properties as needed
          ));
        }
      }

      return completedTasks;
    } else {
      // Handle non-successful status codes (e.g., 404, 500, etc.) here
      print(
          'Failed to get completed tasks. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    print('An error occurred while fetching completed tasks from the API: $e');
    return [];
  }
}

Future<List<Task>> fetchUncompletedTasksFromAPI() async {
  print('Fetching uncompleted tasks from API');

  try {
    final apiEndpoint = Uri.parse('$ENDPOINT/todos?key=$API_KEY');

    final response = await http.get(apiEndpoint);

    if (response.statusCode == 200) {
      // Parse the JSON response body into a list of tasks
      List<dynamic> data = json.decode(response.body);
      List<Task> uncompletedTasks = [];

      for (var item in data) {
        if (item['done'] == false) {
          uncompletedTasks.add(Task(
            id: item['id'] as String? ?? '',
            name: item['title'] as String? ?? '',
            done: item['done'] as bool? ?? false,
            // Add other properties as needed
          ));
        }
      }

      return uncompletedTasks;
    } else {
      // Handle non-successful status codes (e.g., 404, 500, etc.) here
      print(
          'Failed to get uncompleted tasks. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    print(
        'An error occurred while fetching uncompleted tasks from the API: $e');
    return [];
  }
}

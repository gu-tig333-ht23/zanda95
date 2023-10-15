import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

//API endpoint and key constants
const String endPoint = 'https://todoapp-api.apps.k8s.gu.se';
const String apiKey = '7c2ee12a-2ec3-4020-bad0-3969f70ef828';

class API {
// GET task list from the API
  static Future<List<Task>> getList() async {
    Uri url = Uri.parse('$endPoint/todos?key=$apiKey');

    http.Response response = await http.get(url);
    String body = response.body;

    List<dynamic> jsonResponse = jsonDecode(body);
    List<Task> filteredTasks =
        jsonResponse.map((json) => Task.fromJson(json)).toList();

    return filteredTasks;
  }

// Add a new task to the API
  Future addTask(Task task) async {
    await http.post(
      Uri.parse('$endPoint/todos?key=$apiKey'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );
  }

// Remove a task from the API
  Future removeTask(task) async {
    var id = task.id;
    await http.delete(Uri.parse('$endPoint/todos/$id?key=$apiKey'));
  }

// Update the status of a task in the API
  Future updateTask(Task task) async {
    var id = task.id;
    await http.put(Uri.parse('$endPoint/todos/$id?key=$apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(task.toJson()));
  }
}

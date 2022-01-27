import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo.dart';

class DataBase {
  final client = http.Client();

  // Add a todo element in the database
  addTodo(String title, String desc, String date) async {
    var url = Uri.parse("http://10.0.2.2:5000/todo");

    Map<String, dynamic> jsonMap = {
      "Title": title,
      "Description": desc,
      "DueDate": "Date('$date')"
    };

    await client
        .post(url,
            headers: {'Content-type': 'application/json'},
            body: jsonEncode(jsonMap))
        .then((http.Response r) => r.body)
        // ignore: avoid_print
        .whenComplete(() => print("add completed"));
  }

  // Delete a todo element from the database
  deleteTodo(int id) async {
    var url = Uri.parse("http://10.0.2.2:5000/delete/$id");

    await client
        .delete(url)
        .then((http.Response r) => r.body)
        // ignore: avoid_print
        .whenComplete(() => print("delete completed"));
  }

  // Update a todo status
  updateTodo(int id) async {
    var url = Uri.parse("http://10.0.2.2:5000/update/$id");

    await client
        .put(url)
        .then((http.Response r) => r.body)
        // ignore: avoid_print
        .whenComplete(() => print("update completed"));
  }

  // Fetch Todos list from database
  getTodos() async {
    try {
      var url = Uri.parse("http://10.0.2.2:5000/todos");
      final response = await client.get(url);
      var list = (json.decode(response.body) as List)
          .map((data) => Todo.fromMap(data))
          .toList();

      return list;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

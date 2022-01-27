import 'package:flutter/material.dart';

import 'package:todo_app/models/todo.dart';

// ignore: must_be_immutable
class TodoDetails extends StatelessWidget {
  Todo todo;
  TodoDetails({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Description :"),
            trailing: Text(todo.description),
          ),
          ListTile(
            title: const Text("Created on :"),
            trailing: Text(todo.createdOn),
          ),
          ListTile(
            title: const Text("Due Date"),
            trailing: Text(todo.dueDate),
          ),
          ListTile(
            title: const Text("Done"),
            trailing: Text(todo.isDone ? "Yes" : "No"),
          ),
        ],
      ),
    );
  }
}

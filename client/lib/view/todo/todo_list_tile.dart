import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/todo_provider.dart';
import 'package:todo_app/service/repository.dart';
import 'package:todo_app/view/todo/todo_details_page.dart';

// ignore: must_be_immutable
class TodoListTile extends StatelessWidget {
  final Todo todo;
  TodoListTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  TodoRepository todoRepository = TodoRepository();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        title: Text(todo.title),
        leading: Checkbox(
          value: todo.isDone,
          activeColor: Colors.red,
          onChanged: (bool? value) {
            Provider.of<TodosModel>(context, listen: false).toggleTodo(todo);
            todoRepository.updateTodo(todo.id);
          },
        ),
        subtitle: Text(todo.description),
        trailing: Column(
          children: [
            Expanded(
              child: Text(
                todo.dueDate,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  todoRepository.deleteTodo(todo.id);
                  Provider.of<TodosModel>(context, listen: false)
                      .deleteTodo(todo);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        isThreeLine: true,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetails(
              todo: todo,
            ),
          ),
        ),
      ),
    );
  }
}

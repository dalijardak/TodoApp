import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/service/repository.dart';

// I used provider to handle state managment in the app

class TodosModel extends ChangeNotifier {
  List<Todo> _todos = [];
  final TodoRepository _todoRepository = TodoRepository();
  UnmodifiableListView<Todo> get alltodos => UnmodifiableListView(_todos);

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void toggleTodo(Todo todo) {
    final todoIndex = _todos.indexOf(todo);
    _todos[todoIndex].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void getAllTodos() async {
    _todos = await _todoRepository.dataBase.getTodos();
    notifyListeners();
  }
}

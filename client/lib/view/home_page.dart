import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_provider.dart';
import 'package:todo_app/service/repository.dart';
import 'package:todo_app/view/todo/add_todo_page.dart';
import 'package:todo_app/view/todo/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final todos = Provider.of<TodosModel>(context, listen: false);
    todos.getAllTodos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TodoRepository todoRepository = TodoRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo List"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (cotnext) => const AddTodoPage(),
            ),
          ),
        ),
        body: Consumer<TodosModel>(
          builder: (context, todos, child) {
            var list = todos.alltodos;
            if (list.isEmpty) {
              return const Center(
                child: Text(
                  "You have nothing to do for today.\n Have fun ! ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return TodoListTile(key: UniqueKey(), todo: list[index]);
              },
              itemCount: list.length,
            );
          },
        ));
  }
}

/* FutureBuilder(
        future: todoRepository.getAllTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var todoList = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemBuilder: (context, index) {
              return TodoListTile(key: UniqueKey(), todo: todoList[index]);
            },
            itemCount: todoList.length,
          );
        },
      ),*/
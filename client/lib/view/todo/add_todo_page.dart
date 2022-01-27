import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/todo_provider.dart';
import 'package:todo_app/service/repository.dart';

class AddTodoPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AddTodoPage();

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TodoRepository todoRepository = TodoRepository();

  final name = TextEditingController();

  final desc = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final DateTime _today = DateTime.now();

  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String date = "${_date.day}/${_date.month}/${_date.year}";
                  todoRepository.addTodo(name.text, desc.text, date);
                  Provider.of<TodosModel>(context, listen: false).addTodo(
                    Todo(
                      title: name.text,
                      description: desc.text,
                      dueDate: date,
                      createdOn: "${_today.day}/${_today.month}/${_today.year}",
                    ),
                  );

                  Navigator.pop(context);
                }
              })
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.title),
              title: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field Required";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.view_headline),
              title: TextFormField(
                controller: desc,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field Required";
                  }
                  return null;
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text("Due Date"),
              subtitle: Text("${_date.day}/${_date.month}/${_date.year}"),
              onTap: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                );
                if (selectedDate != null) {
                  setState(() {
                    _date = selectedDate;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

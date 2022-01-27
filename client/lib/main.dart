import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_provider.dart';
import 'package:todo_app/view/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodosModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App Dali Jardak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

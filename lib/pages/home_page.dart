import 'package:flutter/material.dart';
import 'package:todolist/components/create_dialog.dart';
import 'package:todolist/data/todo_db.dart';
import 'package:todolist/models/task.dart';

import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State <HomePage> createState() => HomePageState();
}

class HomePageState extends State <HomePage> {

  TodoDb db = TodoDb();

  void showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateDialog(
          onSave: (text) => createTask(text),
          onCancel: () => Navigator.of(context).pop(),
        );
      }, 
    );
  }

  void createTask(String text) {
    if(text.isNotEmpty) {
      setState(() {
        db.todoList.add(Task(name: text, completed: false));
      });
      db.updateList();
    }
    Navigator.of(context).pop();
  }

  void completedChanged(bool? value, int index) {
    setState(() {
      db.todoList[index].completed = !db.todoList[index].completed;
    });    
    db.updateList();
  }

  void deleteTask(Task task) {
    setState(() {
      db.todoList.remove(task);
    });
    db.updateList();
  }

  @override
  void initState() {
    db.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text("Ｔ　Ｏ　Ｄ　Ｏ"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            task: db.todoList[index],
            onChange: (value) => completedChanged(value, index),
            onDelete: (context) => deleteTask(db.todoList[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
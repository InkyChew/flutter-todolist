import 'package:flutter/material.dart';
import 'package:todolist/components/color_dialog.dart';
import 'package:todolist/components/create_dialog.dart';
import 'package:todolist/data/todo_db.dart';
import 'package:todolist/models/task.dart';

import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  final Color themeColor;
  final Function(Color) changeTheme;

  const HomePage({super.key, required this.themeColor, required this.changeTheme});

  @override
  State <HomePage> createState() => HomePageState();
}

class HomePageState extends State <HomePage> {

  void showColorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ColorDialog(
          currentColor: widget.themeColor,
          changeColor: widget.changeTheme
        );
      }
    );
  }

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

  void reorderList(int oldIndex, int newIndex) {
    setState(() {
      // update newIndex when drag up
      if(oldIndex < newIndex) newIndex--;
      var tile = db.todoList.removeAt(oldIndex);
      db.todoList.insert(newIndex, tile);
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Ｔ　Ｏ　Ｄ　Ｏ"),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: showColorDialog,
            icon: const Icon(Icons.color_lens)
          )
        ],
      ),
      body: ReorderableListView.builder(        
        padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            key: ValueKey(db.todoList[index]),
            task: db.todoList[index],
            onChange: (value) => completedChanged(value, index),
            onDelete: (context) => deleteTask(db.todoList[index]),
          );
        },
        onReorder: (int oldIndex, int newIndex) => reorderList(oldIndex, newIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
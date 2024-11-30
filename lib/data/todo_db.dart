import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';

class TodoDb {
  static const key = "TODOLIST";
  List<Task> todoList = [
    Task(name: "Play Flutter!", completed: false),
    Task(name: "Go Yoga.", completed: true),
    Task(name: "Write thankful diary.", completed: false),
  ];

  final _todoBox = Hive.box<List>("todoBox");

  void getList() {
    todoList = (_todoBox.get(key, defaultValue: todoList) ?? []).cast<Task>();
  }

  void updateList() {
    _todoBox.put(key, todoList);
  }
}
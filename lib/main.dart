import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/app_db.dart';
import 'models/task.dart';
import 'pages/home_page.dart';

Future<void> main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<List>('todoBox');
  await Hive.openBox<int>('colorBox');
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppDb db = AppDb();

  void changeTheme(Color color) {
    setState(() {
      db.themeColor = color.value;
      db.updateThemeColor();
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    db.getThemeColor();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todolist',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(db.themeColor)),
        useMaterial3: true,
      ),
      home: HomePage(
        themeColor: Color(db.themeColor),
        changeTheme: changeTheme
      ),
    );
  }
}
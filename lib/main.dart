// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_project/data/task_inherited.dart';
import 'package:flutter_project/screens/form_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: TaskInherited(
        child: HomeScreen(),
      ),
    );
  }
}

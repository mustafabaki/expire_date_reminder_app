// @dart=2.9

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'homepage.dart';
import 'database.dart';

void main() async {
  runApp(const myApp());

  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper.instance;
}

class myApp extends StatefulWidget {
  const myApp({Key key}) : super(key: key);

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      title: 'Expire Date Reminder',
      debugShowCheckedModeBanner: false,
    );
  }
}

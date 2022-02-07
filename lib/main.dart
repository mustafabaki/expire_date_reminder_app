// @dart=2.9

import 'package:flutter/material.dart';
import 'homepage.dart';
import 'database.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  runApp(const myApp());

  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper.instance;
  // initialize the alarm manager
  AndroidAlarmManager.initialize();

  //check periodically the expiration dates of the products

  AndroidAlarmManager.periodic(const Duration(days: 1), 1, notify);

}

void notify(){
// TODO: complete this function for notification functionality.

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

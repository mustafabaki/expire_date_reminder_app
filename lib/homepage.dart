// @dart=2.9
import 'package:flutter/material.dart';
import 'database.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;

  List<Map<dynamic, dynamic>> records = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dbHelper.queryAllRows().then((value) {
      records = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Expire Date Reminder'),
          centerTitle: true,
        ),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            alignment: Alignment.bottomRight,
            ringColor: Colors.white.withAlpha(25),
            ringDiameter: 400.0,
            ringWidth: 150.0,
            fabSize: 64.0,
            fabElevation: 8.0,
            fabIconBorder: const CircleBorder(),
            fabColor: Colors.white,
            fabOpenIcon: Icon(Icons.menu, color: primaryColor),
            fabCloseIcon: Icon(Icons.close, color: primaryColor),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            children: [
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.settings),
              ),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        body: records.length == 0
            ? Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  child: Text(
                    "You do not have any product in your list. Tap the button to add some products!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: MediaQuery.of(context).size.width * 0.09),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: records?.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Text(records[index]['name']),
                      Text(records[index]['date'])
                    ],
                  );
                }));
  }
}

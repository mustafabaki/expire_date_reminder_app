// @dart=2.9

import 'dart:io';

import 'package:expire_date_reminder_app/add_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  final today = DateTime.now();

  void refresh() {
    setState(() {});
  }

  Future<List<Map<dynamic, dynamic>>> getAll() async {
    return dbHelper.queryAllRows();
  }

  List<Map<dynamic, dynamic>> records = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dbHelper.queryAllRows().then((value) {
      print(value);
      setState(() {
        records = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    XFile image;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          title: const Text('Expire Date Reminder'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // go to the product add page
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const addProduct()));
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.done && projectSnap.data.length !=0 ) {
              return ListView.builder(
                  itemCount: records?.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    bool isNull;
                    if (records[index]['pic'] == null) {
                      isNull = true;
                    } else {
                      isNull = false;
                    }
                    return ListTile(
                        title: Text(records[index]['name']),
                        subtitle: Text(
                            "Remaining days to expiration: ${today.difference(DateTime(int.parse(records[index]['year']), int.parse(records[index]['month']), int.parse(records[index]['day']))).inDays * (-1)}"),
                        leading: isNull == false
                            ? Image(
                                image: Image.file(File(records[index]['pic']))
                                    .image,
                              )
                            : const Icon(Icons.shopping_cart_outlined));
                  });
            }
              return Center(
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
              );
            }
          ,
          future: getAll(),
        ));
  }
}

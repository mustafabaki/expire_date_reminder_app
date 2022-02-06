// @dart=2.9

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'homepage.dart';

class addProduct extends StatefulWidget {
  const addProduct({Key key}) : super(key: key);

  @override
  _addProductState createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  TextEditingController name = TextEditingController();
  DateTime selectedDate = DateTime.now();
  ImagePicker imagePicker = ImagePicker();
  String path;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the product name',
                )),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Colors.blue, backgroundColor: Colors.blue),
            onPressed: () async {
              final DateTime picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
              );
              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                  print(selectedDate.day);
                });
              }
            },
            child: const Text(
              'Choose the expire date of the product',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Column(
            children: [

              TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.blue, backgroundColor: Colors.blue),
                onPressed: () async {
                  imagePicker.pickImage(source: ImageSource.camera).then((value) async {
                    Directory directory = await getApplicationDocumentsDirectory();
                    path = directory.path;

                    path = path+"/"+value.name;

                    value.saveTo(path);
                  });

                },
                child: const Text(
                  'Capture product image using camera',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 150,
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Colors.blue, backgroundColor: Colors.blue),
            onPressed: () async {
              final dbHelper = DatabaseHelper.instance;

              dbHelper.insert({'name':name.text,'day': selectedDate.day.toString(), 'month':selectedDate.month.toString(), 'year':selectedDate.year.toString(), 'pic': path});

              // refresh the homepage's state
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));

            },
            child: const Text(
              'Add the product',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

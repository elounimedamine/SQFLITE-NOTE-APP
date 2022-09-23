import 'package:flutter/material.dart';
import 'package:sqflite_project/Home_Test_SQFLITE.dart';
import 'package:sqflite_project/addNotes.dart';
import 'package:sqflite_project/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLITE APP',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        "addnotes" : ((context) => const AddNotes()),
        "homepage" : ((context) => const HomePage()),
      },
    );
  }
}

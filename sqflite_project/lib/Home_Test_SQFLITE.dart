import 'package:flutter/material.dart';
import 'package:sqflite_project/sqldb.dart';

class HomePageTestSQFLITE extends StatefulWidget {
  const HomePageTestSQFLITE({super.key});

  @override
  State<HomePageTestSQFLITE> createState() => _HomePageTestSQFLITEState();
}

class _HomePageTestSQFLITEState extends State<HomePageTestSQFLITE> {
  SqlDb sqldb = SqlDb(); //instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  List<Map> response = await sqldb.readData("SELECT * FROM 'notes'");
                  print("$response");
                },
                color: Colors.red,
                child: const Text(
                  'Read Data',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  int response = await sqldb
                      .insertData("INSERT INTO 'notes'('note') VALUES('note one')");
                  print(response);
                },
                color: Colors.red,
                child: const Text(
                  'Insert Data',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  int response = await sqldb
                      .deleteData("DELETE FROM 'notes' WHERE id = 3");
                  print("$response");
                },
                color: Colors.red,
                child: const Text(
                  'Delete Data',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  int response = await sqldb
                      .updateData("UPDATE 'notes' SET 'note' = 'note five' WHERE id = 5");
                  print("$response");
                },
                color: Colors.red,
                child: const Text(
                  'Update Data',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

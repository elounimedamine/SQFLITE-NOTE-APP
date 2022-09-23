import 'package:flutter/material.dart';
import 'package:sqflite_project/editNotes.dart';
import 'package:sqflite_project/sqldb.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDb sqlDb = SqlDb();
  bool isloading = true;
  List notes = [];

  Future readData() async {
    // List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    List<Map> response = await sqlDb.read("notes");
    notes.addAll(response);
    isloading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.of(context).pushNamed("addnotes");
          }),
          child: const Icon(Icons.add)),
      // ignore: avoid_unnecessary_containers
      body: isloading == true
          ? const Center(child: Text('Loading...'))
          // ignore: avoid_unnecessary_containers
          : Container(
              child: ListView(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      await sqlDb.removeDataBase();
                    },
                    child: const Text(
                      'Drop DataBase',
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Card(
                        child: ListTile(
                            title: Text('${notes[i]['title']}'),
                            subtitle: Text('${notes[i]['note']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    // int response = await sqlDb.deleteData(
                                    //     "DELETE FROM notes WHERE id = ${notes[i]['id']} ");
                                    int response = await sqlDb.delete(
                                        "notes", 'id = ${notes[i]['id']}');
                                    if (response > 0) {
                                      notes.removeWhere((element) =>
                                          element['id'] == notes[i]['id']);
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => EditNotes(
                                                  id: notes[i]['id'],
                                                  title: notes[i]['title'],
                                                  note: notes[i]['note'],
                                                  color: notes[i]['color'],
                                                )));
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blue,
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite_project/home.dart';
import 'package:sqflite_project/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: ListView(padding: const EdgeInsets.all(10), children: [
        Form(
            key: formstate,
            child: Column(
              children: [
                TextField(
                  controller: title,
                  decoration:
                      const InputDecoration(hintText: "Enter your title"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: note,
                  decoration:
                      const InputDecoration(hintText: "Enter your note"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: color,
                  decoration:
                      const InputDecoration(hintText: "Enter your color"),
                ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async {
                    // int response = await sqlDb
                    //     .insertData('''INSERT INTO notes(title, note, color)
                    //        VALUES ('${title.text}','${note.text}','${color.text}')''');
                    int response = await sqlDb.insert("notes", {
                      // ignore: unnecessary_string_interpolations
                      "title" : "${title.text}",
                      // ignore: unnecessary_string_interpolations
                      "note" : "${note.text}",
                      // ignore: unnecessary_string_interpolations
                      "color" : "${color.text}",
                    });
                    if (response > 0) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    }
                  },
                  color: Colors.blue,
                  child: const Text(
                    'Add Note',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ))
      ]),
    );
  }
}

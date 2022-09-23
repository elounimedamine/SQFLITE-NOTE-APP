// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sqflite_project/home.dart';
import 'package:sqflite_project/sqldb.dart';

class EditNotes extends StatefulWidget {
  final id, title, note, color;
  const EditNotes({super.key, this.id, this.title, this.note, this.color});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    title.text = widget.title;
    note.text = widget.note;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Notes'),
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
                    // int response = await sqlDb.updateData(
                    //     ''' UPDATE notes SET title = '${title.text}', note = '${note.text}', color = '${color.text}'
                    //     WHERE id = ${widget.id}
                    //      ''');
                    int response = await sqlDb.update(
                        "notes",
                        {
                          // ignore: unnecessary_string_interpolations
                          "title": "${title.text}",
                          // ignore: unnecessary_string_interpolations
                          "note": "${note.text}",
                          // ignore: unnecessary_string_interpolations
                          "color": "${color.text}",
                        },
                        'id = ${widget.id}');
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
                    'Edit Note',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ))
      ]),
    );
  }
}

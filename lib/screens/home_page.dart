import 'package:flutter/material.dart';
import 'package:hive_tutorial/constants/constants_helper.dart';
import 'package:hive_tutorial/database/database_helper.dart';
import 'package:hive_tutorial/models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/widgets/alert_dialog.dart';
import 'package:hive_tutorial/widgets/notes__card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return ExtendedAlertDialogue(
                  tittle: "Enter a tittle",
                  notes: "Enter a notes",
                  isEdit: false,
                  model: NotesModel(id: DateTime.now(), tittle: '', notes: ''),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(ConstantsHelper.appBarTittle),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: DatabaseHelper().getDatabaseInitialized().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return NotesCard(data: data[index]);
            },
          );
        },
      ),
    );
  }
}

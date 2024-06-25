import 'package:flutter/material.dart';
import 'package:hive_tutorial/constants/all_global_constants.dart';
import 'package:hive_tutorial/constants/constants_helper.dart';
import 'package:hive_tutorial/database/database_helper.dart';
import 'package:hive_tutorial/database/database_methods.dart';
import 'package:hive_tutorial/models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tittleController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(ConstantsHelper.addNotes),
                  content:  SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                            controller: tittleController,
                            decoration: textFieldBorder),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: notesController,
                          decoration: textFieldBorder,
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text(ConstantsHelper.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(ConstantsHelper.add),
                      onPressed: () {
                        DatabaseMethods().storeData(tittleController.text,
                            notesController.text, DateTime.now());
                        tittleController.clear();
                        notesController.clear();
                        Navigator.of(context).pop();
                      },
                    )
                  ],
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
        builder: (context, box, _){
          var data = box.values.toList().cast<NotesModel>();

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index){
              print("data is ${data[index].tittle}");
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    DatabaseMethods().deleteData(data[index]);
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(data[index].tittle.toString()),
                          Text(data[index].notes.toString())

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },

          );
        },

      ),
    );
  }
}

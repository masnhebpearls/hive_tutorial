import 'package:flutter/material.dart';
import 'package:hive_tutorial/models/notes_model.dart';

import '../constants/all_global_constants.dart';
import '../database/database_methods.dart';
import 'alert_dialog.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key, required this.data});

  final NotesModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          try {
            DatabaseMethods().deleteData(data);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  backgroundColor: Colors.tealAccent,
                  textColor: Colors.white,
                  label: "Undo",
                  onPressed: () {
                    DatabaseMethods()
                        .storeData(data.tittle!, data.notes!, data.id!);
                  },
                ),
                backgroundColor: Colors.white,
                content: const Text(
                  "deleted successfully",
                  style: titleTextStyle,
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  "failed delete",
                  style: titleTextStyle,
                ),
              ),
            );
          }
        },
        child: InkWell(
          onTap: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return ExtendedAlertDialogue(
                    tittle: data.tittle!,
                    notes: data.notes!,
                    isEdit: true,
                    model: data,
                  );
                });
          },
          child: Card(
            color: Colors.tealAccent,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.tittle.toString(),
                        style: titleTextStyle,
                      ),
                      Text(
                        data.notes.toString(),
                        style: noteTextStyle,
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return ExtendedAlertDialogue(
                                tittle: data.tittle!,
                                notes: data.notes!,
                                isEdit: true,
                                model: data,
                              );
                            });
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

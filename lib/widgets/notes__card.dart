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
          DatabaseMethods().deleteData(data);
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
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 15),
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
                  IconButton(onPressed: () async {
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

                  }, icon: const Icon(Icons.edit))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

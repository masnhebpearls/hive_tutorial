import 'package:flutter/material.dart';
import 'package:hive_tutorial/models/notes_model.dart';

import '../constants/all_global_constants.dart';
import '../database/database_methods.dart';
import 'alert_dialog.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({super.key, required this.data});

  final NotesModel data;

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {

  void _showDialogue() async {
    await showDialog(
        context: context,
        builder: (context) {
          return ExtendedAlertDialogue(
            isEdit: true,
            model: widget.data,
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          try {
            DatabaseMethods().deleteData(widget.data);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  backgroundColor: Colors.tealAccent,
                  textColor: Colors.white,
                  label: "Undo",
                  onPressed: () {
                    DatabaseMethods()
                        .storeData(widget.data.tittle!, widget.data.notes!, widget.data.id!);
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
          onTap: _showDialogue,
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
                        widget.data.tittle.toString(),
                        style: titleTextStyle,
                      ),
                      Text(
                        widget.data.notes.toString(),
                        style: noteTextStyle,
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: _showDialogue,
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

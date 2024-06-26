import 'package:flutter/material.dart';
import 'package:hive_tutorial/models/notes_model.dart';

import '../constants/all_global_constants.dart';
import '../constants/constants_helper.dart';
import '../database/database_methods.dart';

class ExtendedAlertDialogue extends StatefulWidget {
  const ExtendedAlertDialogue(
      {super.key, required this.isEdit, required this.model});

  final bool isEdit;
  final NotesModel model;

  @override
  State<ExtendedAlertDialogue> createState() => _ExtendedAlertDialogueState();
}

class _ExtendedAlertDialogueState extends State<ExtendedAlertDialogue> {
  final tittleController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.isEdit
          ? const Text(ConstantsHelper.editNotes)
          : const Text(ConstantsHelper.addNotes),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
                controller: tittleController,
                decoration:
                    textFieldBorder.copyWith(hintText: widget.model.tittle!)),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: notesController,
              decoration:
                  textFieldBorder.copyWith(hintText: widget.model.notes!),
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
          onPressed: !widget.isEdit
              ? () {
                  DatabaseMethods().storeData(tittleController.text,
                      notesController.text, widget.model.id!);
                  tittleController.clear();
                  notesController.clear();
                  Navigator.of(context).pop();
                }
              : () {
                  if (tittleController.text != widget.model.tittle &&
                      tittleController.text.isNotEmpty) {
                    DatabaseMethods()
                        .updateTittle(widget.model, tittleController.text);
                  }
                  if (notesController.text != widget.model.notes &&
                      notesController.text.isNotEmpty) {
                    DatabaseMethods()
                        .updateNotes(widget.model, notesController.text);
                  }
                  tittleController.clear();
                  notesController.clear();
                  Navigator.of(context).pop();
                },
          child: !widget.isEdit
              ? const Text(ConstantsHelper.add)
              : const Text(ConstantsHelper.edit),
        )
      ],
    );
  }
}

import 'package:hive_tutorial/database/database_helper.dart';
import 'package:hive_tutorial/models/notes_model.dart';

class DatabaseMethods extends DatabaseHelper {
  void storeData(String tittle, String notes, DateTime id) {
    final data = NotesModel(tittle: tittle, notes: notes, id: id);
    final box = getDatabaseInitialized();
    box.add(data);
    data.save();
  }

  void deleteData(NotesModel model) async {
    await model.delete();
  }

  void updateTittle(NotesModel model, String newTittle) async {
    if (newTittle.isNotEmpty) {
      model.tittle = newTittle;
      await model.save();
    }
  }

  void updateNotes(NotesModel model, String newNotes) async {
    if (newNotes.isNotEmpty) {
      model.notes = newNotes;
      await model.save();
    }
  }
}

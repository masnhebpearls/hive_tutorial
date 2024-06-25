import 'package:hive_tutorial/database/database_helper.dart';
import 'package:hive_tutorial/models/notes_model.dart';

class DatabaseMethods extends DatabaseHelper {

  void storeData(String tittle, String notes, DateTime id ) {
    print("initial $notes");
    final data = NotesModel(tittle: tittle, notes: notes, id: id);
    final box = getDatabaseInitialized();
    print("here ${data.notes}");
    box.add(data);
    data.save();
  }

  void deleteData(NotesModel model) async {
    await model.delete();
  }



  // Future<String> getData() async {
  //   try {
  //     final box =  getDatabaseInitialized();
  //     final variable = box.get('name');
  //     if (variable != null) {
  //       return variable;
  //     } else {
  //       return '';
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
  //
  // Future<void> deleteData() async {
  //   try {
  //     final box = await getDatabaseInitialized();
  //     box.delete('name');
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // Future<void> putData() async {
  //   try {
  //     final box = await getDatabaseInitialized();
  //     box.put('name', 'mansh');
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}

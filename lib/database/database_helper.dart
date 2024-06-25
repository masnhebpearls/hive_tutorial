import 'package:hive/hive.dart';
import 'package:hive_tutorial/constants/constants_helper.dart';
import 'package:hive_tutorial/models/notes_model.dart';

class DatabaseHelper {
 Box<NotesModel> getDatabaseInitialized()  {
    return Hive.box<NotesModel>(ConstantsHelper.noteBoxName);
  }
}

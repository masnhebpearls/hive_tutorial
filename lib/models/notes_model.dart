import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject{
  @HiveField(0)
  final String tittle;

  @HiveField(1)
  final String notes;

  @HiveField(2)
  final DateTime id;

  NotesModel({required this.tittle, required this.notes, required this.id});
}

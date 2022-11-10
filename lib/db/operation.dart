import 'package:MyFest/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
class Operation {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'C:/Users/gutie/users.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE users (id INTEGER PRIMARY KEY, title TEXT, description TEXT, address TEXT, addressNumber TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insert(Note note) async {
    Database database = await _openDB();

    return database.insert("users", note.toMap());
  }

  static Future<int> delete(Note note) async {
    Database database = await _openDB();

    return database.delete("notes", where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<int> update(Note note) async {
    Database database = await _openDB();

    return database.update("notes",note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }


  
  static Future<List<Note>> users() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> notesMap = await database.query("users");
    for (var n in notesMap) {
      print("____"+n['title']);
    }
  
    return List.generate(
        notesMap.length,
        (i) => Note(
          id: notesMap[i]['id'], 
          title: notesMap[i]['title'], 
          description: notesMap[i]['description'], 
          address: notesMap[i]['address'], 
          addressNumber: notesMap[i]['addressNumber'])
          );
  }
}

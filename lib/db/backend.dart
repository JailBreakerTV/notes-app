import 'package:Notes/note.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Backend {
  Future<Database> database;

  Future<void> open() async {
    WidgetsFlutterBinding.ensureInitialized();
    this.database = openDatabase(
      join(await getDatabasesPath(), "note.db"),
      onCreate: (db, version) {
        return db.execute(
          "create table if not exists notes(" +
              "note_id integer primary key autoincrement, " +
              "topic text, " +
              "value text, " +
              "expire_at integer, " +
              "created_at integer" +
              ");",
        );
      },
      version: 1,
    );
  }

  Future<void> insertNote(Note note) async {
    final Database db = await this.database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> notes() async {
    final Database db = await this.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(
      maps.length,
      (i) {
        return Note.fromJson(maps[i]);
      },
    );
  }

  Future<void> updateNote(Note note) async {
    final Database db = await this.database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'note_id = ?',
      whereArgs: [note.noteId],
    );
  }

  Future<void> deleteNote(Note note) async {
    final Database db = await this.database;
    await db.delete(
      'notes',
      where: 'note_id = ?',
      whereArgs: [note.noteId],
    );
  }
}

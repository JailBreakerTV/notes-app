import 'package:Notes/main.dart';
import 'package:flutter/cupertino.dart';

import '../note.dart';

class NoteListViewModel extends ChangeNotifier {
  List<Note> notes;

  Future<void> loadAllNotes() async {
    this.notes = await backend.notes();
    notifyListeners();
  }

  void addNote(Note note) {
    if (this.notes != null) {
      this.notes.add(note);
      notifyListeners();
    }
  }

  void removeNote(Note note) {
    if (this.notes != null) {
      this.notes.removeWhere((element) => element.noteId == note.noteId);
      notifyListeners();
    }
  }

  void updateNote(Note note) {
    if (this.notes != null) {
      this.notes.removeWhere((element) => element.noteId == note.noteId);
      this.notes.add(note);
      notifyListeners();
    }
  }
}

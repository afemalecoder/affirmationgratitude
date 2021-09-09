import 'package:affirmation_gratitude/model/note.dart';
import 'package:flutter/cupertino.dart';

/// TODO: Change to a network class that interacts with firebase
class NotesOperation extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    addNewNote('First Note', 'First Note description ');
  }

  void addNewNote(String title, String content) {
    final Note note = Note(title: title, content: content);
    _notes.add(note);
    notifyListeners();
  }
}

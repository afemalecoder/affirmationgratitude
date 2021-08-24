class Note {
  // final String id;
  String title;
  String content;
  // NoteState state;

  Note({
    // required this.id,
    required this.title,
    required this.content,
    // required this.state,
  });
}

enum NoteState {
  saved,
  deleted,
}

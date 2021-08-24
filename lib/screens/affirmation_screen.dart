import 'package:affirmation_gratitude/screens/add_notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:affirmation_gratitude/model/note_operation.dart';
import 'package:affirmation_gratitude/model/note.dart';

class AffirmationScreen extends StatelessWidget {
  static const routeName = '/affirmation';
  const AffirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff464bbd),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => Navigator.pushNamed(
            context,
            AddNoteScreen.routeName,
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Color(0xff464bbd),
          ),
        ),
        appBar: AppBar(
          title: const Text('Affirmation'),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, 'home'),
                icon: const Icon(Icons.home),
              ),
            ),
          ],
        ),
        body: Consumer<NotesOperation>(
          builder: (context, NotesOperation data, child) {
            return ListView.builder(
              itemCount: data.getNotes.length,
              itemBuilder: (context, index) {
                return NotesCard(data.getNotes[index]);
              },
            );
          },
        ));
  }
}

class NotesCard extends StatelessWidget {
  // const NotesCard({
  //   Key? key,
  // }) : super(key: key);

  final Note note;
  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              note.title,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Text(
              note.content,
              maxLines: 3,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}

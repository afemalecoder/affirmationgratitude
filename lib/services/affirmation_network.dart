import 'package:affirmation_gratitude/model/affirmation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AffirmationNetwork extends ChangeNotifier {
  AffirmationNetwork();
  final User firebaseUser = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;

  List<Affirmation> notes = [
    Affirmation(
      id: 'odsufhsoifekfw3',
      date: DateTime.now().toString(),
      title: 'Dummy Title',
      content:
          'This the content of a dummy affirmation for tests purpose, this affirmation is one that loves bugs, muhshhshs bug are nice, they are like the good bacterias',
      mood: 'Happy',
    )
  ];

  Stream<QuerySnapshot<Map<String, dynamic>>> getAffirmation() {
    final String userAffirmationsPath =
        'affirmations/${firebaseUser.uid}/affirmations';
    return db.collection(userAffirmationsPath).snapshots();
  }

  void addNewNote({
    required String date,
    required String? title,
    required String content,
    required String mood,
  }) async {
    final String userAffirmationsPath =
        'affirmations/${firebaseUser.uid}/affirmations';

    await db.collection(userAffirmationsPath).add({
      'date': date,
      'title': title,
      'content': content,
      'mood': mood,
    }).then((DocumentReference ref) {
      final Affirmation affirmation = Affirmation(
        id: ref.id,
        date: date,
        title: title,
        content: content,
        mood: mood,
      );
      notes.add(affirmation);
      notifyListeners();
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AffirmationNetwork extends ChangeNotifier {
  AffirmationNetwork();
  final User _firebaseUser = FirebaseAuth.instance.currentUser!;
  final _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> watchAffirmations() {
    final String userAffirmationsPath =
        'affirmations/${_firebaseUser.uid}/affirmations';
    return _db.collection(userAffirmationsPath).orderBy('date').snapshots();
  }

  Future<void> addNewNote({
    required String date,
    required String? title,
    required String content,
    required String mood,
  }) async {
    final String userAffirmationsPath =
        'affirmations/${_firebaseUser.uid}/affirmations';

    await _db.collection(userAffirmationsPath).add({
      'date': date,
      'title': title,
      'content': content,
      'mood': mood,
    });
  }
}

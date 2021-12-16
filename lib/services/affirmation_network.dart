import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    final String affirmationsPath =
        'affirmations/${_firebaseUser.uid}/affirmations';

    await _db.collection(affirmationsPath).add({
      'date': date,
      'title': title,
      'content': content,
      'mood': mood,
    }).then((reference) async {
      await _db.doc('$affirmationsPath/${reference.id}').update(
        {'id': reference.id},
      );
    });
  }

  Future<void> deleteAffirmation(BuildContext context, String id) async {
    final String affirmationPath =
        'affirmations/${_firebaseUser.uid}/affirmations/$id';
    try {
      await _db.doc(affirmationPath).delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<void> addQuote({
    required String date,
    required String? author,
    required String quote,
  }) async {
    final String affirmationsPath =
        'affirmations/${_firebaseUser.uid}/quotes';

    await _db.collection(affirmationsPath).add({
      'date': date,
      'author': author,
      'quote': quote,
    }).then((reference) async {
      await _db.doc('$affirmationsPath/${reference.id}').update(
        {'id': reference.id},
      );
    });
  }

}


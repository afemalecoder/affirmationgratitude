import 'package:affirmation_gratitude/screens/authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AffirmationAuth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint('$e');
      return;
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signUp(
    BuildContext context, {
    required String displayName,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser!.updateDisplayName(displayName);

      await _createCloudFirestoreUser(newUser, displayName);

      await login(context, email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  Future<void> _createCloudFirestoreUser(
    UserCredential newUser,
    String displayName,
  ) async {
    await _db.collection('users').add(<String, dynamic>{
      'uid': newUser.user!.uid,
      'email': newUser.user!.email,
      'displayname': displayName,
    });
  }
}

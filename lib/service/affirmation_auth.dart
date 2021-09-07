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
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _createCloudFirestoreUser(newUser);

      await login(context, email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  Future<void> _createCloudFirestoreUser(UserCredential newUser) async {
    await _db.collection('users').add(<String, dynamic>{
      'uid': newUser.user!.uid,
      'email': newUser.user!.email,
    });
  }
}

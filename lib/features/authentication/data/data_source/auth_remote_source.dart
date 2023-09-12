import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRemoteSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteSource(this._firebaseAuth, this._firestore);

  //STREAM OF AUTH USER
  Stream<User?> getUser() {
    return _firebaseAuth.authStateChanges();
  }

//  SIGNUP WITH EMAIL AND PASSWORD
  Future<bool> signUp(String email, String password) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection("USERS").add({
        'id': user.user?.uid,
        'email': user.user?.email,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Check credentials and try again');
    }
  }

  //  SIGNUP WITH EMAIL AND PASSWORD
  Future<bool> signIn(String email, String password) async {
    try {
      if (email != "geonavadmin@gmail.com") {
        throw Exception('Check credentials and try again');
      }
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on Exception catch (e) {
      throw Exception('Check credentials and try again');
    } catch (e) {
      throw Exception('Check credentials and try again');
    }
  }
}

final authDataSource = Provider(
  (ref) {
    return AuthRemoteSource(FirebaseAuth.instance, FirebaseFirestore.instance);
  },
);

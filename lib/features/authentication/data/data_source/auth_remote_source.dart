import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRemoteSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  AuthRemoteSource(this._firebaseAuth, this._firestore);

  //STREAM OF AUTH USER
  Stream<User?> getUser (){
    return _firebaseAuth.authStateChanges();
  }

//  SIGNUP WITH EMAIL AND PASSWORD
  Future<bool> signUp(String email, String password) async {
    try {
      print(email);
      print(password);
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(user.user?.email);
      // await _firestore.collection("USERS").add({
      //   'id': user.user?.uid,
      //   'email': user.user?.email,
      // });
      return true;
    } on FirebaseAuthException catch (e){
      throw Exception(e.message);
    }catch (e) {
      throw Exception('Check credentials and try again');
    }
  }

  //  SIGNUP WITH EMAIL AND PASSWORD
  Future<bool> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
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

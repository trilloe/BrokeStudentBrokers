import 'package:broke_student_brokers/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// import 'package:broke_student_brokers/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // // create user object based on firebase user
  // User _userFromFirebaseUser(User user) {
  //   return user != null ? User(uid: user.uid) : null;
  // }

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // // Get current user
  // Future getCurrentUser() async {
  //   return _auth.currentUser;
  // }

  // // Get uid
  // Future<String> getCurrentUID() async {
  //   return (_auth.currentUser).uid;
  // }

  // sign-in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign-in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // create a new doc for user with uid
      await DatabaseService(uid: user.uid)
          .updateUserData(500, true, [], [], [], {});

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

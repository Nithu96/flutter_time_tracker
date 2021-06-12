import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class User1 {
  User1 ({@required this.uid});
  final String uid;
}

abstract class AuthBase{
  Future<User1> currentUser();
  Future<User1> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  
  User1 _userFromFirebase (User user){
    if (user == null){
      return null;
    }
    return User1(uid: user.uid);
  }

  Future<User1> currentUser() async {
   final user = await _firebaseAuth.currentUser;
   return _userFromFirebase(user);

  }
  Future<User1> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User1 {
  User1 ({@required this.uid});
  final String uid;
}

abstract class AuthBase{
  Stream<User1> get onAuthStateChanged;
  Future<User1> currentUser();
  Future<User1> signInAnonymously();
  Future<User1> signInWithGoogle();
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

  @override
  Stream<User1> get onAuthStateChanged{
    // ignore: deprecated_member_use
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User1> currentUser() async {
   final user = _firebaseAuth.currentUser;
   return _userFromFirebase(user);

  }

  Future<User1> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User1> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        final authResult = await _firebaseAuth.signInWithCredential(
          // ignore: deprecated_member_use
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;

  //for sign up
  Future<User?> createUserWithEmailAndPassword(String email,String password)async{
      try{
        final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return cred.user;
      }catch(e){
        log("Error : $e");
      }
      return null;
  }

  //for sign in
  Future<User?>  loginUserWithEmailAndPassword(String email,String password)async {
    // print(email);
    // print(password);
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
      else {
        log("Error : $e");
      }
      return null;
    }
  }
  Future<void>signout() async
  {
    try{
      await _auth.signOut();
    }catch(e)
    {
      log("Error : $e");
    }
  }
}
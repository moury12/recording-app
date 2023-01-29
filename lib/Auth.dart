import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//final authServiceProvider = Provider( create: (BuildContext context) {return AuthService(

    //firestore: FirebaseFirestore.instance);  },);
class AuthService {
  static User? get currentUser => auth.currentUser;
  static final auth = FirebaseAuth.instance;
static final  firestore=FirebaseFirestore.instance;
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  static Future<void> logout() async {
    return FirebaseAuth.instance.signOut();
  }
}
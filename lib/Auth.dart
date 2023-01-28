import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'helper_function.dart';

BuildContext? context;
class AuthService {
  static UserCredential? userCredential;
  static final _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;
  static Future<UserCredential> verifyPhone(String phone,String verId,int screenState,String otpPin)async{
    final credential = await _auth.verifyPhoneNumber(
      phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential){
          showMsg(context!, "AUth Completed");
        },
        verificationFailed: (FirebaseAuthException e){
      showMsg(context!, 'Auth failed');
    },
        codeSent: (String verificationId,int? resendToken){
    showMsg(context!, 'Otp Sent');
    verId =verificationId;
    },
        codeAutoRetrievalTimeout: (String verificationId){
    showMsg(context!, 'Timeout');
    });
   return userCredential!;
  }
  static Future<UserCredential> verifyOtp(String verId,String otpPin)async{
   final credential = _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verId, smsCode: otpPin)

    );
    return credential;}
  static Future<void> logout() async {
    return _auth.signOut();
  }
}
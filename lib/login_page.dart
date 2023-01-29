import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/helper_function.dart';
import 'package:recoding_flutter_app/launcher_page.dart';
import 'package:recoding_flutter_app/provider.dart';
import 'package:recoding_flutter_app/userModel_google.dart';
import 'package:recoding_flutter_app/user_model.dart';

import 'Auth.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  static const String routeName ='/login';
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  var phone='';
  String otpPin='';
  String verId='';
  String countryDial ='+880';
  int screenState=0;
  static final auth=FirebaseAuth.instance;
  static User? get currentUser=>auth.currentUser;
  Future<void> verifyPhone(String number) async{
    auth.verifyPhoneNumber(phoneNumber: number,
        timeout: Duration(seconds: 35),
        verificationCompleted: (PhoneAuthCredential credential){
          showMsg(context, "AUth Completed");
        },
        verificationFailed: (FirebaseAuthException e){
          showMsg(context, 'Auth failed');
        },
        codeSent: (String verificationId,int? resendToken){
          showMsg(context, 'Otp Sent');
          verId =verificationId;
          setState(() {
            screenState=1;
          });
        }, codeAutoRetrievalTimeout: (String verificationId){
          showMsg(context, 'Timeout');
        });
  }
  Future<void> verifyOtp()async{
    auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verId, smsCode: otpPin)
    ).whenComplete(() {
      final user=UserModel(phone: _phoneController.text,userId: generateUserId);
      contentProvider.addUser(user);
      Navigator.pushReplacementNamed(context, Dash.routeName);

    });
  }
  void _signInWithGoogle() async {
    if(AuthService.currentUser!=null){
      final idToken = await AuthService.currentUser!.getIdToken();
      final credential = GoogleAuthProvider.credential(idToken: idToken);
    }
    else{
      try{
        final credential = await AuthService.signInWithGoogle();
        final userExist = await contentProvider.doesUserExist(credential.user!.uid);
        if (!userExist) {

          final guser = GoogleUserModel(
              userId: credential.user!.uid,
              email: credential.user!.email!,
              name: credential.user!.displayName!,

              userCreationTime: Timestamp.fromDate(DateTime.now()));
          await contentProvider.addGoogleUser(guser);


        }
        if(mounted){
          Navigator.pushReplacementNamed(context, Dash.routeName);
        }
      }   catch(error){

        rethrow;
      }
    }

  }
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
  late ContentProvider contentProvider;
  @override
  void didChangeDependencies() {
    contentProvider=Provider.of<ContentProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        setState(() {
          screenState=0;
        });
        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                screenState==0?stateRegister():otpPart(),
SizedBox(height: 40,),
                FloatingActionButton.extended( icon:
                  Image.asset('assets/j.png',height: 27,width: 27,),



        onPressed: _signInWithGoogle, label: Text('Sign In with Google'),
    )
              ]),
        ),
      ),
    );}
  Widget stateRegister(){
    return Column(
      children: [Text('phone verfication'),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,

          decoration: InputDecoration(
            hintText: 'Phone No:',
            suffixIcon: Icon(Icons.call)
          ),
        ),
        ElevatedButton(onPressed: (){
          if(screenState==0){
            if(_phoneController.text.isEmpty){
              showMsg(context, 'Please provide Phone Number');
            }
            else{
              verifyPhone(_phoneController.text);
            }
          }
          else{
            Text('null');
          }
        }, child: Text('Send the code'))],
    );
  }
  Widget otpPart(){
    return Column(
      children: [
        RichText(text: TextSpan(
            children: [
              TextSpan(text: 'Sent Code on Your Sms'),
              TextSpan(text: countryDial + _phoneController.text),
              TextSpan(text: 'Enter Your Code here'),

            ]
        )),
        PinCodeTextField(appContext: context, length: 6, onChanged:(value){ setState(() {
          otpPin=value;
        });print(otpPin);
        },
          pinTheme: PinTheme(
              activeColor: Colors.white70,
              selectedColor: Colors.blueGrey,
              inactiveColor: Colors.black
          ),
        ),
        ElevatedButton(onPressed: (){
          if(screenState!=0){
            if(otpPin.length>=6){
              verifyOtp();
            }else{
              showMsg(context, 'enter otp correctly');
            }
          }
        }, child: Text('verify'))
      ],
    );
  }

}


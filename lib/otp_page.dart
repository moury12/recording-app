import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/dashboard_page.dart';
import 'package:recoding_flutter_app/login_page.dart';
import 'package:recoding_flutter_app/provider.dart';
import 'package:recoding_flutter_app/user_model.dart';

class OtpPage extends StatefulWidget {
  static const String routeName ='/otp';
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
final FirebaseAuth auth =FirebaseAuth.instance;
var code='';

  var errorMsg='';
late ContentProvider contentProvider;
@override

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
body: Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Column(crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,children: [
    Text('Send code'),
    Container(
      height: 55,
      width: double.infinity,
    ),Pinput(
  length: 6,
      validator: (s) {
        return s == '2222' ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin){
    code=pin;
      }  ,
    ),ElevatedButton(onPressed: ()async{
     try{
       PhoneAuthCredential credential =PhoneAuthProvider.credential(verificationId: LoginPage.verify, smsCode: code);
       auth.signInWithCredential(credential);
Navigator.pushNamed(context, DashboardPage.routeName);
     }on FirebaseAuthException catch(error){
       setState(() {
         errorMsg=error.message!;
       });
     }
      }, child: Text('verify')),//Text("${errorMsg}",style: TextStyle(color: Colors.red, fontWeight: FontWeight.w100,fontSize: 8))
  ],),
),
    );}
}


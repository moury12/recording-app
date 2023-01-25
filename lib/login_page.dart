import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/otp_page.dart';
import 'package:recoding_flutter_app/provider.dart';
import 'package:recoding_flutter_app/user_model.dart';

class LoginPage extends StatefulWidget {
  static const String routeName ='/login';
  const LoginPage({Key? key}) : super(key: key);
static String verify='';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
var phone='';
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
    return Scaffold(appBar: AppBar(),
     body: Padding(
       padding: const EdgeInsets.all(18.0),
       child: Column(crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
         Text('phone verfication'),
         TextField(
          onChanged: (value){
            phone=value;
          },
           keyboardType: TextInputType.phone,
           decoration: const InputDecoration(
               suffixIcon: Icon(Icons.phone), labelText: 'Phone no'),

         ),
         ElevatedButton(onPressed: ()async{
         if(_phoneController!=null){
           await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phone,
               verificationCompleted: (PhoneAuthCredential credential){}, verificationFailed: (FirebaseAuthException e){}, codeSent: (String verficationId, int? resendToken){
             LoginPage.verify=verficationId;
             Navigator.pushNamed(context, OtpPage.routeName);
               }, codeAutoRetrievalTimeout: (String verficationId){});
           final user=UserModel( phone: phone);
           await contentProvider.addUser(user);
         }
         else{
           Text('null');
         }
         }, child: Text('Send the code'))
       ],),
     ),
    );}
}


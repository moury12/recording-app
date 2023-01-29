
import 'package:flutter/cupertino.dart';
import 'auth/Auth.dart';
import 'models/audio_model.dart';
import 'models/text_model.dart';
import 'models/userModel_google.dart';
import 'models/user_model.dart';
import 'database.dart';
import 'models/video_model.dart';
class ContentProvider extends ChangeNotifier{
 UserModel? userModel;
GoogleUserModel? googleUserModel;

  AudioModel? audioModel;
 Future<void> addUser(UserModel user) {
   return dbHelper.addUser(user);
 }
 Future<void> addGoogleUser(GoogleUserModel guser) {
   return dbHelper.addGoogleUser(guser);
 }

 Future<void> addAudio(AudioModel audios) async{
   return dbHelper.addAudio(audios);
 }

 getGUserInfo() {
   dbHelper.getGUserInfo(AuthService.currentUser!.uid).listen((snapshot) {
     if (snapshot.exists) {
       googleUserModel = GoogleUserModel.fromMap(snapshot.data()!);
       notifyListeners();
     }
   });
 }
 getUserInfo() {
   dbHelper.getUserInfo(userModel!.userId).listen((snapshot) {
     if (snapshot.exists) {
       userModel = UserModel.fromMap(snapshot.data()!);
       notifyListeners();
     }
   });
 }

 Future<void> addNote(TextModel notes) async{
   return dbHelper.addText(notes);
 }

 Future <void> addVideo(VideoModel video) async{
   return dbHelper().addVideo(video);
 }



 Future<bool> doesUserExist(String uid) => dbHelper.doesUserExist(uid);



}
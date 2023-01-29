import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:recoding_flutter_app/audio_model.dart';
import 'package:recoding_flutter_app/database.dart';
import 'package:recoding_flutter_app/helper_function.dart';
import 'package:recoding_flutter_app/text_model.dart';
import 'package:recoding_flutter_app/userModel_google.dart';
import 'package:recoding_flutter_app/user_model.dart';
import 'package:recoding_flutter_app/video_model.dart';

import 'Auth.dart';

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
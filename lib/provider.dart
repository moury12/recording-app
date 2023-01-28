import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:recoding_flutter_app/audio_model.dart';
import 'package:recoding_flutter_app/database.dart';
import 'package:recoding_flutter_app/helper_function.dart';
import 'package:recoding_flutter_app/text_model.dart';
import 'package:recoding_flutter_app/user_model.dart';
import 'package:recoding_flutter_app/video_model.dart';

class ContentProvider extends ChangeNotifier{
 UserModel? userModel;
  AudioModel? audioModel;
 Future<void> addUser(UserModel user) {
   return dbHelper.addUser(user);
 }

 Future<void> addAudio(AudioModel audios) async{
   return dbHelper.addAudio(audios);
 }

 Future<void> addNote(TextModel notes) async{
   return dbHelper.addText(notes);
 }

 Future <void> addVideo(VideoModel video) async{
   return dbHelper().addVideo(video);
 }

 Future<String> uploadvideo(String? s) async{
   final photoRef= FirebaseStorage.instance.ref().child('Vid/${DateTime.now().microsecondsSinceEpoch}.mp4');
   final uploadTask=photoRef.putFile(File(s!));
   final snapshot= await uploadTask.whenComplete(() => const Text('Upload Sucessfully'));
   return snapshot.ref.getDownloadURL();
 }
 Future<void> deleteVideo(String? downloadurl) async {
   FirebaseStorage.instance.refFromURL(downloadurl!).delete();
 }

}
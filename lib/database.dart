import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recoding_flutter_app/audio_model.dart';
import 'package:recoding_flutter_app/text_model.dart';
import 'package:recoding_flutter_app/user_model.dart';
import 'package:recoding_flutter_app/video_model.dart';

class dbHelper{
  static final db =FirebaseFirestore.instance;

  static Future<void> addUser(UserModel user) async{
    return db.collection(collectionUser).doc(user.userId).set(user.toMap());
  }

  static Future<void> addAudio(AudioModel audios) async{
    return db.collection(collectionAudio).doc(audios.audioId).set(audios.toMap());
  }

  static Future<void> addText(TextModel notes) async{
    return db.collection(collectionText).doc(notes.textId).set(notes.toMap());
  }



  Future<void> addVideo(VideoModel video) async{
    return db.collection(collectionVideo).doc(video.videoId).set(video.toMap());
  }}
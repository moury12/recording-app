import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/audio_model.dart';
import 'models/text_model.dart';
import 'models/userModel_google.dart';
import 'models/user_model.dart';
import 'models/video_model.dart';

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
  }

  static Future<void> addGoogleUser(GoogleUserModel guser) {
    return db.collection(collectiongoogleUser).doc(guser.userId).set(guser.toMap());

  }
  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await db.collection(collectiongoogleUser).doc(uid).get();
    return snapshot.exists;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getGUserInfo(
      String uid) =>
      db.collection(collectiongoogleUser).doc(uid).snapshots();
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String userId) =>
      db.collection(collectionUser).doc(userId).snapshots();


}
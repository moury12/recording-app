import 'package:cloud_firestore/cloud_firestore.dart';

const String collectionUser = 'user';
const String userFieldId = 'userid';
const String userFieldtext = 'txt';
const String userFieldaudio = 'audio';
const String userFieldvideo = 'video';
const String userFieldCreationTime = 'CreationTime';
const String userFieldPhone = 'phone';
class UserModel {
  String userId;
  String phone;
  String text;
  String audio;
  String video;
  Timestamp? userCreationTime;

  UserModel(
      { required this.userId,
        this.userCreationTime,
        this.audio='',
        this.text='',
        this.video='',
        required this.phone,
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldId: userId,
      userFieldCreationTime: userCreationTime,
      userFieldtext:text,
      userFieldaudio:audio,
      userFieldvideo:video,
      userFieldPhone: phone,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      userId: map[userFieldId],
      userCreationTime: map[userFieldCreationTime],
      text: map[userFieldtext],
      audio: map[userFieldaudio],
      video: map[userFieldvideo],
      phone: map[userFieldPhone]);

}

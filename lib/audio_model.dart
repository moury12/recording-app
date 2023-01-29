import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recoding_flutter_app/userModel_google.dart';
import 'package:recoding_flutter_app/user_model.dart';

const String collectionAudio = 'Audios';
const String audioFieldUserModel = 'userModel';
const String audioFieldCreationTime = 'CreationTime';
const String audioFieldId = 'videoid';
const String audioFieldlink = 'Link';
class AudioModel {
  String audioId;
  GoogleUserModel user;

  String audioLink;
  Timestamp? audioCreationTime;

  AudioModel(
      {required this.audioId,
        required this.user,

        this.audioCreationTime,
        required this.audioLink,
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      audioFieldId: audioId,
      audioFieldUserModel: user.toMap(),

      audioFieldCreationTime: audioCreationTime,
      audioFieldlink: audioLink,

    };
  }

  factory AudioModel.fromMap(Map<String, dynamic> map) => AudioModel(
      audioId: map[audioFieldId],
      user: GoogleUserModel.fromMap(map[audioFieldUserModel]),
      audioCreationTime: map[audioFieldCreationTime],
      audioLink: map[audioFieldlink]);

}

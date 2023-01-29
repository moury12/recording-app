import 'package:cloud_firestore/cloud_firestore.dart';

import 'userModel_google.dart';


const String collectionVideo = 'video';
const String videoFieldUserModel = 'userModel';
const String videoFieldCreationTime = 'CreationTime';
const String videoFieldId = 'videoid';
const String videoFieldlink = 'Link';
class VideoModel {
  String videoId;
  GoogleUserModel user;
  String videoLink;
  Timestamp? videoCreationTime;

  VideoModel(
      {required this.videoId,
        required this.user,

        this.videoCreationTime,
        required this.videoLink,
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      videoFieldId: videoId,
      videoFieldUserModel: user.toMap(),

      videoFieldCreationTime: videoCreationTime,
      videoFieldlink: videoLink,

    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) => VideoModel(
      videoId: map[videoFieldId],
      user: GoogleUserModel.fromMap(map[videoFieldUserModel]),
      videoCreationTime: map[videoFieldCreationTime],
      videoLink: map[videoFieldlink]);

}

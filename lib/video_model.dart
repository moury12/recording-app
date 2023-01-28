import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recoding_flutter_app/user_model.dart';

const String collectionVideo = 'Videos';
const String videoFieldUserModel = 'userModel';
const String videoFieldCreationTime = 'CreationTime';
const String videoFieldId = 'videoid';
const String videoFieldlink = 'Link';
class VideoModel {
  String videoId;

  String videoLink;
  Timestamp? videoCreationTime;

  VideoModel(
      {required this.videoId,

        this.videoCreationTime,
        required this.videoLink,
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      videoFieldId: videoId,

      videoFieldCreationTime: videoCreationTime,
      videoFieldlink: videoLink,

    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) => VideoModel(
      videoId: map[videoFieldId],


      videoCreationTime: map[videoFieldCreationTime],
      videoLink: map[videoFieldlink]);

}

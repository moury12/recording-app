import 'package:recoding_flutter_app/user_model.dart';

const String collectionVideo = 'Videos';
const String videoFieldUserModel = 'userModel';
const String videoFieldId = 'videoid';
const String videoFieldlink = 'Link';
class VideoModel {
  String? videoId;
UserModel userModel;
  String videoLink;


  VideoModel(
      { this.videoId,
required this.userModel,
        required this.videoLink,
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      videoFieldId: videoId,
videoFieldUserModel:userModel.toMap(),
      videoFieldlink: videoLink,

    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) => VideoModel(
      videoId: map[videoFieldId],
userModel:  UserModel.fromMap(map[videoFieldUserModel]),
      videoLink: map[videoFieldlink]);

}

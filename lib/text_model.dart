import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recoding_flutter_app/user_model.dart';

const String collectionText = 'Notes';
const String textFieldUserModel = 'userModel';
const String textFieldCreationTime = 'CreationTime';
const String textFieldId = 'noteid';
const String textFieldlink = 'Link';
class TextModel {
  String textId;
UserModel userModel;
 String textLink;
  Timestamp? textCreationTime;

  TextModel(
      {required this.textId,
required this.userModel,
        this.textCreationTime,
        required this.textLink,
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      textFieldId: textId,
textFieldUserModel: userModel.toMap(),
      textFieldCreationTime: textCreationTime,
      textFieldlink: textLink,

    };
  }

  factory TextModel.fromMap(Map<String, dynamic> map) => TextModel(
      textId: map[textFieldId],
  userModel: map[textFieldUserModel],
      textCreationTime: map[textFieldCreationTime],
  textLink: map[textFieldlink]);
}

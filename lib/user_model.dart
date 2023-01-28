import 'package:cloud_firestore/cloud_firestore.dart';

const String collectionUser = 'user';
const String userFieldId = 'userid';
const String userFieldCreationTime = 'CreationTime';
const String userFieldPhone = 'phone';
class UserModel {
  String userId;
  String phone;
  Timestamp? userCreationTime;

  UserModel(
      { required this.userId,
        this.userCreationTime,
        required this.phone,
      });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldId: userId,
      userFieldCreationTime: userCreationTime,
      userFieldPhone: phone,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      userId: map[userFieldId],
      userCreationTime: map[userFieldCreationTime],
      phone: map[userFieldPhone]);

}

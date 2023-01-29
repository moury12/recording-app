import 'package:cloud_firestore/cloud_firestore.dart';

const String collectiongoogleUser = 'Google User';
const String userFieldIdg = 'userid';
const String userFieldnameg = 'name';

const String userFieldCreationTimeg = 'CreationTime';
const String userFieldemailg = 'email';

class GoogleUserModel {
  String? name;
  String? userId;
  String? email;
  Timestamp? userCreationTime;

  GoogleUserModel({
   this.userId,
     this.name,
    this.userCreationTime,

   this.email,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldIdg: userId,
      userFieldnameg: name,
      userFieldCreationTimeg: userCreationTime,

      userFieldemailg: email,
    };
  }

  factory GoogleUserModel.fromMap(Map<String, dynamic> map) => GoogleUserModel(
      userId: map[userFieldIdg],
      name: map[userFieldnameg],
      userCreationTime: map[userFieldCreationTimeg],

      email: map[userFieldemailg]);
}

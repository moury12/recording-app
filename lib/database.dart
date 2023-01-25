import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recoding_flutter_app/user_model.dart';

class dbHelper{
  static final db =FirebaseFirestore.instance;

  static Future<void> addUser(UserModel user) async{
    return db.collection(collectionUser).doc(user.userId).set(user.toMap());
  }}
import 'package:flutter/cupertino.dart';
import 'package:recoding_flutter_app/database.dart';
import 'package:recoding_flutter_app/user_model.dart';

class ContentProvider extends ChangeNotifier{
 Future<void> addUser(UserModel user) {
   return dbHelper.addUser(user);
 }

}
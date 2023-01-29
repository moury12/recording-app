import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/provider.dart';
class UserPhonePage extends StatelessWidget {
  static const String routeName ='/Pprofile';

  const UserPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ContentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Profile'),
      ),
      body: userProvider.userModel == null
          ? const Center(
        child: Text('Failed to load user data'),
      )
          :

      ListTile(
        leading: const Icon(Icons.person),
        title: Text(userProvider.userModel!.phone??''),

      ),
    );
  }
}

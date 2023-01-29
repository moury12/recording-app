import 'package:flutter/material.dart';
import 'package:recoding_flutter_app/launcher_page.dart';

import 'Auth.dart';
import 'login_page.dart';

class Dash extends StatelessWidget {
  static const String routeName ='/';

  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (AuthService.currentUser != null) {
        Navigator.pushReplacementNamed(context, LauncherPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    return const Placeholder();
  }
}

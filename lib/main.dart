import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/page/dashboard.dart';

import 'package:recoding_flutter_app/provider.dart';

import 'page/text_page.dart';
import 'page/audio_page.dart';
import 'page/launcher_page.dart';
import 'page/login_page.dart';
import 'page/profile.dart';
import 'page/video_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
   ChangeNotifierProvider(create: (_)=>ContentProvider())
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recording App',
      theme: ThemeData(
        
        primarySwatch: Colors.lime,
      ),
    initialRoute: Dash.routeName,
    routes: {

      Dash.routeName:(_)=>const Dash(),
    LauncherPage.routeName:(_)=>const LauncherPage(),
    UserPage.routeName:(_)=>const UserPage(),
        LoginPage.routeName:(_)=>const LoginPage(),
        New.routeName:(_)=>const New(),
        VideoPage.routeName:(_)=>const VideoPage(),
       AudioPage.routeName:(_)=>const AudioPage(),
    }
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/page/profile.dart';
import 'package:recoding_flutter_app/page/text_page.dart';
import 'package:recoding_flutter_app/page/video_page.dart';

import 'package:recoding_flutter_app/provider.dart';

import '../auth/Auth.dart';
import 'audio_page.dart';
import 'login_page.dart';



class LauncherPage extends StatefulWidget {
  static const String routeName ='/launch';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  final _txtController = TextEditingController();
  String videoLink='';
  @override
  void dispose() {
    _txtController.dispose();
    super.dispose();
  }
  late ContentProvider contentProvider;
  @override
  void didChangeDependencies() {
    Provider.of<ContentProvider>(context, listen: false).getGUserInfo();
    contentProvider=Provider.of<ContentProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, UserPage.routeName);
            },
            icon: Icon(Icons.person),),
          ],
        ),
        title: Text('Dashboard'),
        actions: [IconButton(onPressed: (){  AuthService.logout().then((value) => Navigator.pushReplacementNamed(context, LoginPage.routeName));}, icon: Icon(Icons.logout)),
         ],

      ),body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ Padding(
          padding: const EdgeInsets.all(18.0),
          child:SizedBox(height: 100,width: 100,
            child: FittedBox(child: FloatingActionButton(heroTag: 'btn1',
              onPressed: (){ Navigator.pushNamed(context, VideoPage.routeName);},
              child:Icon(Icons.video_call, size:30,color: Colors.white,),  )),
          ),
        ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(height: 100,width: 100,
              child: FittedBox(child: FloatingActionButton(heroTag: 'btn2',
                  onPressed: (){Navigator.pushNamed(context, AudioPage.routeName);},
                  child:Icon(Icons.spatial_audio, size:30,color: Colors.white) )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(height: 100,width: 100,
              child: FittedBox(child: FloatingActionButton(heroTag: 'btn3',
                  onPressed:  (){Navigator.pushNamed(context,New.routeName);},
                  child:Icon(Icons.note_add, size:30,color: Colors.white) )),
            ),
          ),
        ],
    ),
      ),
    );}
}



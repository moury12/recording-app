

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recoding_flutter_app/dashboard_page.dart';
import 'package:recoding_flutter_app/login_page.dart';
import 'package:video_player/video_player.dart';

import 'audio_model.dart';


class LauncherPage extends StatefulWidget {
  static const String routeName ='/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
   late VideoPlayerController _controller;

  String videoLink='';


@override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [FloatingActionButton(onPressed:() {
          _startvideoRecording(ImageSource.camera);
        },child: Icon(Icons.video_call),),

          ElevatedButton(onPressed: (){Navigator.pushNamed(context, DashboardPage.routeName);}, child: Text('='))
        ],),
      )
    );
  }

   Future<void> getvideo() async{
     final File file =File(videoLink);
     if(videoLink!=null){
       _controller == VideoPlayerController.file(file);
       await _controller.initialize();
       await _controller.setLooping(true);
       await _controller.play();
       super.initState();
     }



}

  void _startvideoRecording(ImageSource camera) async{
    final pickedVideo=await ImagePicker().pickVideo(source: ImageSource.camera);
    if(pickedVideo!=null){
      setState(() {
        videoLink=pickedVideo.path;
      });
    }
  }

@override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}

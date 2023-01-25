
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPage extends StatefulWidget {
  static const String routeName ='/audio';
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
bool isrecorderReady =false;
final recorder =FlutterSoundRecorder();
@override
  void initState() {
    super.initState();
    initRecorder();
  }
  @override
  void dispose() {
   recorder.closeRecorder();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<RecordingDisposition>(stream: recorder.onProgress,
                builder: (context, snapshot) {

                final duration =snapshot.hasData?snapshot.data!.duration
                    :Duration.zero;
                String twoDigits(int n)=>n.toString().padLeft(30);
                final  twoDigitMinutes=twoDigits(duration.inMinutes.remainder(60));
                final  twoDigitsec=twoDigits(duration.inSeconds.remainder(60));

                return Text('${duration.inSeconds}s');


              },),
FloatingActionButton(onPressed: ()async{
  if(recorder.isRecording){
    await stop();
  }
  else{
    await record();
  }
  setState(() {

  });
}, child: Icon(recorder.isRecording?Icons.stop: Icons.mic),

)
          ]),
        ));
  }
Future record() async{

  if(!isrecorderReady) return;
  await recorder.startRecorder(toFile: 'audio');
}
 Future stop() async{
   if(!isrecorderReady) return;
   final path= await recorder.stopRecorder();
    final audioFile=File(path!);
    print('$audioFile');
 }

  Future initRecorder() async{
  final status = await Permission.microphone.request();
  if(status!= PermissionStatus.granted){
    throw'MicroPhone permission not granted';
  }
  await recorder.openRecorder();
  isrecorderReady=true;
  recorder.setSubscriptionDuration(Duration(milliseconds: 500));
  }

}


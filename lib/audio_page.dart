

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/audio_model.dart';
import 'package:recoding_flutter_app/helper_function.dart';
import 'package:recoding_flutter_app/launcher_page.dart';
import 'package:recoding_flutter_app/provider.dart';
import 'package:recoding_flutter_app/userModel_google.dart';

class AudioPage extends StatefulWidget {
  static const String routeName ='/audio';
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {

bool isrecorderReady =false;
String? audio;
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
late ContentProvider contentProvider;
@override
void didChangeDependencies() {
  contentProvider=Provider.of<ContentProvider>(context, listen: false);
  super.didChangeDependencies();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Audio'),),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StreamBuilder<RecordingDisposition>(stream: recorder.onProgress,
                  builder: (context, snapshot) {

                 final duration =snapshot.hasData?snapshot.data!.duration
                      :Duration.zero;
                 String twoDigits(int n)=>n.toString().padLeft(30);
                  final  twoDigitMinutes=twoDigits(duration.inMinutes.remainder(60));
                  final  twoDigitsec=twoDigits(duration.inSeconds.remainder(60));

                  return Text('${duration.inMinutes}:${duration.inSeconds}s',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40));


                },),
 Padding(
   padding: const EdgeInsets.all(20),
   child: SizedBox(height: 180,width: 180,
     child: FittedBox(
       child: FloatingActionButton(onPressed: ()async{
          if(recorder.isRecording){
            await stop();
          }
          else{
            await record();
          }
          setState(() {

          });
        }, focusColor :Colors.cyan,
         child: Icon(recorder.isRecording?Icons.stop: Icons.mic,size: 50,color: Colors.white),

        ),
     ),
   ),
 ),

                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: _saveAudio, child: Text('Save')),SizedBox(width: 30,),
                    ElevatedButton(onPressed: ()async{
                      if(audio!=null){
                        final file = await File(audio!);
                        await file.delete();
                        audio=null;
                        showMsg(context, 'video deleted');
                        Navigator.pushNamed(context, LauncherPage.routeName);

                      }else{
                        showMsg(context, 'there is no video');
                      }
                   }
                        , child: Text('delete')),
                  ],
                )
            ]),
          ),
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
audio=audioFile.path;
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


  Future<void> _saveAudio() async {

    if(audio==null){
      showMsg(context, 'Provide Audio');
    }
    else{

     final audios= AudioModel(audioId: generateAudioId,
       user:  GoogleUserModel(userId: contentProvider.googleUserModel!.userId,
           name: contentProvider.googleUserModel!.name, email: contentProvider.googleUserModel!.email),
       audioLink: audio!,audioCreationTime: Timestamp.fromDate(DateTime.now()),
          );
      try{
        await contentProvider.addAudio(audios);
audio=null;
        showMsg(context, 'Audio saved');
        Navigator.pushNamed(context, LauncherPage.routeName);
      }catch (error) {
          print(error.toString());
          rethrow;
        }
    }
    }


  }



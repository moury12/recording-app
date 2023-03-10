import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/helper_function.dart';
import 'package:recoding_flutter_app/provider.dart';


import '../models/userModel_google.dart';
import '../models/video_model.dart';
import 'launcher_page.dart';

class VideoPage extends StatefulWidget {
  static const String routeName ='/video';
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  String? videoLink;

 late ContentProvider contentProvider;
 @override
 void didChangeDependencies() {
   contentProvider=Provider.of<ContentProvider>(context, listen: false);
   super.didChangeDependencies();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Add Video'),
    ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.all(50),
                child: Center(child: SizedBox(height: 180,width: 180,
                    child: FittedBox(child: FloatingActionButton(onPressed: (){_startvideoRecording(ImageSource.camera);}, child: const Icon(Icons.video_call,size: 50,color: Colors.white))))),
              ),
videoLink!=null?Text('video uploaded now save it or delete it!'):Text(''),
Row(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: saveVideo,
                        child: Text('Save video')),SizedBox(width: 30,),
                    ElevatedButton(onPressed: ()async{
                   if(videoLink!=null){
                     final file = await File(videoLink!);
                     await file.delete();
                     videoLink=null;
                     showMsg(context, 'video deleted');
                     Navigator.pushNamed(context, LauncherPage.routeName);
                   }else{
                     showMsg(context, 'there is no video');
                   }

                    }, child: Text('Delete video')),],
                )
              ],
            ),
          ),
        ));
  }
  void _startvideoRecording(ImageSource camera) async{
    final pickedVideo=await ImagePicker().pickVideo(source: ImageSource.camera);

    if(pickedVideo!=null){
      setState(() {
        videoLink=pickedVideo.path;
      });
    }
  }


  void saveVideo() async{
   if(videoLink==null){
     showMsg(context, 'provide a video');
   }
   else{

     try{

       final video=VideoModel(videoId: generateVideoId,
           user:  GoogleUserModel(userId:contentProvider.googleUserModel==null?null : contentProvider.googleUserModel!.userId,
               name: contentProvider.googleUserModel==null?null :contentProvider.googleUserModel!.name, email:contentProvider.googleUserModel==null?null : contentProvider.googleUserModel!.email),
           videoLink: videoLink!, videoCreationTime: Timestamp.fromDate(DateTime.now()));
contentProvider.addVideo(video);
       videoLink=null;
showMsg(context, 'Video saved');
       Navigator.pushNamed(context, LauncherPage.routeName);

     }catch(error){


     }
   }
  }
}


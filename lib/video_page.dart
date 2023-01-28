import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/helper_function.dart';
import 'package:recoding_flutter_app/provider.dart';
import 'package:recoding_flutter_app/video_model.dart';
import 'package:path_provider/path_provider.dart'as pathpro;
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
     String? videoUrl;
     try{
       await contentProvider.uploadvideo(videoLink!);
       final video=VideoModel(videoId: generateVideoId,  videoLink: videoLink!, videoCreationTime: Timestamp.fromDate(DateTime.now()));
contentProvider.addVideo(video);
       videoLink=null;
showMsg(context, 'Video saved');

     }catch(error){
       await contentProvider.deleteVideo(videoUrl);

     }
   }
  }
}


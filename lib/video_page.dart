import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoPage extends StatefulWidget {
  static const String routeName ='/video';
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  final _txtController = TextEditingController();
  String videoLink='';
  @override
  void dispose() {
    _txtController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [ElevatedButton(onPressed: (){_startvideoRecording(ImageSource.camera);}, child: Text('video'))
            ],
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
  Column _headerSectionTwo(BuildContext context) {
    return Column(
      children: [

      ],
    );}
}


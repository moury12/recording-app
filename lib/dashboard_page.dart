
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recoding_flutter_app/audio_page.dart';
import 'package:recoding_flutter_app/new.dart';
import 'package:recoding_flutter_app/video_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName ='/dash';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

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
appBar: AppBar(


),body: Row(
      children: [ IconButton(onPressed: (){ Navigator.pushNamed(context, VideoPage.routeName);},icon:Icon(Icons.video_call) ),
        IconButton(onPressed: (){Navigator.pushNamed(context, AudioPage.routeName);},icon:Icon(Icons.audiotrack) ),
        IconButton(onPressed:  (){Navigator.pushNamed(context,New.routeName);},icon:Icon(Icons.textsms_rounded) ),
      ],
    ),
    );}

 Column _headerSectionThree(BuildContext context) {
    return Column(
      children: [

      ],
    );
 }


  }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recoding_flutter_app/helper_function.dart';
import 'package:recoding_flutter_app/provider.dart';
import 'package:recoding_flutter_app/text_model.dart';
import 'package:recoding_flutter_app/user_model.dart';

class New extends StatefulWidget {
  static const String routeName ='/txt';
  const New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
late TextModel txtModel;
  final _txtController = TextEditingController();
  late ContentProvider contentProvider;
  @override
  void dispose() {
    _txtController.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    contentProvider=Provider.of<ContentProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Add Notes'),),
body: Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Column(crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextField(
          controller: _txtController,
          maxLines: 5,
          decoration: const InputDecoration(
          suffixIcon: Icon(Icons.textsms_rounded), labelText: 'Write Something'),
      ),
            ElevatedButton(onPressed: _saveText, child: Text('Save')),
            ElevatedButton(onPressed: (){if(_txtController.text.isEmpty){
              showMsg(context, 'There is no text');
            }else{
              _txtController.clear();
              showMsg(context, 'Text Deleted');

            }
    }, child: Text('delete')),
      ],
      ),
));
  }



 void _saveText() async{
    if(_txtController.text.isEmpty){
      showMsg(context, 'Provide a text');
return;
  }
  else{
    try{
      final notes=TextModel(textId: generateNoteId, userModel: UserModel(phone: contentProvider.userModel!.phone,userId: contentProvider.userModel!.userId), textLink: _txtController.text,textCreationTime: Timestamp.fromDate(DateTime.now()));
    await contentProvider.addNote(notes);
_txtController.clear();
showMsg(context, "Your Text saved");
    }catch (error) {

    Text(error.toString());
    rethrow;
    }
    }

  }
}


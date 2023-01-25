import 'package:flutter/material.dart';

class New extends StatefulWidget {
  static const String routeName ='/newuser';
  const New({Key? key}) : super(key: key);

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {

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
body: Column(
        children: [
        TextField(
        controller: _txtController,
        maxLines: 5,
        decoration: const InputDecoration(
        suffixIcon: Icon(Icons.textsms_rounded), labelText: 'Write Something'),
    )
    ],
    ));
  }
  Column _headerSectionTwo(BuildContext context) {
    return Column(
      children: [

      ],
    );}
}


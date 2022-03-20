import 'package:flutter/material.dart';

import '../../../../helper/utils.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(

leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
  backPressed();
},

),
      title: Text('this is a chat title'),),
    body: WillPopScope(
      onWillPop: backPressed,
      child: Container(
        color: Colors.red,

      ),
    ),

    );
  }

  Future<bool> backPressed () async {
    Utils.mainDashNav.currentState!.pushReplacementNamed('/');
    return true;
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    Get.back();
    //Utils.mainDashNav.currentState!.pushReplacementNamed('/');
    return true;
  }

}

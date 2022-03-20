import 'package:doc_talk/models/otp_verification.dart';

import 'package:flutter/material.dart';

import '../../../helper/utils.dart';
import '../../../models/recent_message_model.dart';
import 'dash_list_views/recent_chat_list.dart';

class DashBoardHomeScreen extends StatelessWidget {
  List<RecentMessageModel> recentMessageList = [];

  @override
  Widget build(BuildContext context) {
    recentMessageList.add(RecentMessageModel( lastMessage: 'check urine', timeStamp: '17:31', lastMessageBy: 'Suresh', groupName: 'Health Care Hospital', ));
    recentMessageList.add(RecentMessageModel( lastMessage: 'ok guys lets meet ', timeStamp: '23:55', lastMessageBy: 'You', groupName: 'Hams Psyc Ward 30', ));
    recentMessageList.add(RecentMessageModel( lastMessage: 'hello, all', timeStamp: '6:10', lastMessageBy: 'Sujan', groupName: 'Karuna Clinic Gyno Ward', ));
    recentMessageList.add(RecentMessageModel( lastMessage: 'ayeshaaa', timeStamp: '5:9', lastMessageBy: 'Rajesh', groupName: 'Teaching Hospital ward Dermotology', ));
    User user = User();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        Positioned(

          top: MediaQuery.of(context).size.height * 0.01,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(top: AppBar().preferredSize.height),

            child: _appbar(context, user),)
        ),
        Positioned(
          child: Container(
            margin: EdgeInsets.only(top: AppBar().preferredSize.height-15),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child:RecentChatList(recentMessageList: recentMessageList,),
          ),
          top: MediaQuery.of(context).size.height * 0.15,
          left: 0,
          right: 0,
          bottom: 0,
        ),
      ]),
    );
  }

  _appbar(BuildContext context, User user) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: user.img != null
                  ? Image.network(user.img.toString())
                  : Text(
                      user.name.toString().substring(0, 1).toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.56,
          ),
          Expanded(
            child: Row(
              children:  [
                IconButton(
                  onPressed: ()  {
               Utils.mainDashNav.currentState!.pushReplacementNamed('/chat').then((value) => print('back again'));

                  },
                 icon: Icon( Icons.add,
                   color: Colors.white,
                   size: 30,),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

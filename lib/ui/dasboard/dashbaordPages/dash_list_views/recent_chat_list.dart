import 'package:flutter/material.dart';

import '../../../../models/recent_message_model.dart';
import '../widget/message_tile.dart';

class RecentChatList extends StatelessWidget {
 final List<RecentMessageModel> recentMessageList;
 RecentChatList({required this.recentMessageList});

 //builder(
 //         itemCount: recentMessageList.length,
 //         itemBuilder: (context,position){
 //

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index){
      return  MessageTile(
                  messageBy: recentMessageList[index].lastMessageBy,
                          groupName: recentMessageList[index].groupName,
                     lastMessageText: recentMessageList[index].lastMessage,
                   time: recentMessageList[index].timeStamp,
      );

    }, separatorBuilder: (context, index){
      return Divider(
        thickness: 0.5,
          color:  Theme.of(context).primaryColor,);
    }, itemCount: recentMessageList.length);
  }
}

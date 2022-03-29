import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/dashboard_data_controller.dart';
import '../../../../models/chat_group_modal.dart';

import '../widget/message_tile.dart';

class RecentChatList extends StatelessWidget {
 final List<ChatGroupModel> recentMessageList;
 final Function(int) onPress;
 final DashboardDataController _controller = Get.put(DashboardDataController());
 RecentChatList({required this.recentMessageList, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index){
      String messageSentBy=recentMessageList[index].lastMessageSenderName;
      String messageTextValue = recentMessageList[index].lastMessageValue;
      if(recentMessageList[index].lastMessageSenderContact==_controller.dashboardDataModal.value.contactNumber){
        messageSentBy = "You";
      }

      if(recentMessageList[index].lastMessageType.toLowerCase()=='img'){
        messageTextValue = "Sent a pic";
      }
      return  MessageTile(
        onPress: (){
          onPress(index);
      },
                  groupId: recentMessageList[index].chatGroupId,
                  messageType:recentMessageList[index].lastMessageType,
                  messageBy:messageSentBy,
                  groupName: recentMessageList[index].chatGroupName,
                  lastMessageText: messageTextValue,
                  time: recentMessageList[index].lastMessageTimeStamp,
      );

    }, separatorBuilder: (context, index){
      return Divider(
        thickness: 0.5,
          color:  Theme.of(context).primaryColor,);
    }, itemCount: recentMessageList.length);
  }
}

import 'dart:convert';

import 'package:doc_talk/models/dasboard_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/chat_group_modal.dart';
import '../models/otp_verification.dart';
import '../networks/api_client.dart';
import '../shared_pref/shared_pref.dart';
import '../shared_pref/shared_pref_const.dart';
import '../ui/dasboard/dashbaordPages/chat/create_chat_group.dart';

enum BackMessageTypeChat{
  USER_ADDED, GROUP_LEAVE
}

class DashboardDataController extends GetxController {
  final dashboardDataModal = DashboardDataModel().obs;
  final fileImage = "".obs;
  final chatGroupContact = <ContactUserInApp>[].obs;

  final userChatGroups = <ChatGroupModel>[].obs;

  final totalUserInGroups = <ChatGroupUserTotal>[].obs;
  final totalOnlineUser = 0.obs;

final chatSettingBackMessage = BackMessageTypeChat.USER_ADDED.obs;

  void updateDashboardData(DashboardDataModel updatedDashboardDataModel) {
    dashboardDataModal.update((newDashboardValue) {
      dashboardDataModal.value = updatedDashboardDataModel;
    });
  }

  void updateFileImage(String imageFile) {
    fileImage.update((newDashboardValueImg) {
      fileImage.value = imageFile;
    });
  }

  void updateChatGroupContacts(List<ContactUserInApp> contactUserInApp) {
    chatGroupContact.value = contactUserInApp;
    chatGroupContact.refresh();
  }


  void updateTotalUserInChatGroup(List<ChatGroupUserTotal> totalUserInChatGroup){
    totalUserInGroups.value = totalUserInChatGroup;
    totalUserInGroups.refresh();
  }


  int getTotalOnline(){
    totalOnlineUser.value=0;
    for(int i=0; i<totalUserInGroups.value.length; i++){
      if(totalUserInGroups.value[i].isOnline){
        totalOnlineUser.update((val) {
          totalOnlineUser.value= totalOnlineUser.value+1;

        });
      }
    }
    return totalOnlineUser.value;
  }

  void updateOnlineStatusOfGroups(List<dynamic> onlineUsers){
try{
  totalOnlineUser.value = 0;
  for(int i=0; i<totalUserInGroups.value.length; i++){
    for(int j=0; j<onlineUsers.length; i++){
      if(totalUserInGroups.value[i].contactNumber==onlineUsers[j]["username"]){
        totalUserInGroups.value[i].isOnline = true;
      }

      else {
        totalUserInGroups.value[i].isOnline = false;
      }

    }

  }
  totalUserInGroups.refresh();
}



catch(e){
  print(e.toString());
}

  }


  void resetChatData(){
    userChatGroups.value=[];
    totalUserInGroups.value=[];
    totalOnlineUser.value=0;

  }

  void updateSelectedUserFromContact(int index) {
    chatGroupContact.value[index].selected =
        !chatGroupContact.value[index].selected;
    chatGroupContact.refresh();
  }


  void updateUserChatGroupList(List<ChatGroupModel> chatGroupsModel){
    userChatGroups.value = chatGroupsModel;
    userChatGroups.refresh();
  }


  void updateChatBackMessage(BackMessageTypeChat messageType){
    chatSettingBackMessage.update((val) {
      chatSettingBackMessage.value = messageType;
    });
  }


}

class ChatGroupUserTotal {
  String name;
  String email;
  String contactNumber;
  String id;
  String speciality;
  String profileImage;
  bool isOnline;
  ChatGroupUserTotal({required this.name,required this.profileImage, required this.email, required this.contactNumber, required this.id,required this.speciality, this.isOnline = false});
}

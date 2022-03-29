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

class DashboardDataController extends GetxController {
  final dashboardDataModal = DashboardDataModel().obs;
  final fileImage = "".obs;
  final chatGroupContact = <ContactUserInApp>[].obs;

  final userChatGroups = <ChatGroupModel>[].obs;


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

  void updateSelectedUserFromContact(int index) {
    chatGroupContact.value[index].selected =
        !chatGroupContact.value[index].selected;
    chatGroupContact.refresh();
  }


  void updateUserChatGroupList(List<ChatGroupModel> chatGroupsModel){
    userChatGroups.value = chatGroupsModel;
    userChatGroups.refresh();
  }


    //void updateLastMessageOfGroup(ind)


}

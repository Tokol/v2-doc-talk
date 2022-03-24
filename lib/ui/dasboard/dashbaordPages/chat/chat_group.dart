import 'package:doc_talk/networks/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/dashboard_data_controller.dart';
import '../../../../models/otp_verification.dart';

class CreateChatGroup extends StatefulWidget {
  @override
  State<CreateChatGroup> createState() => _CreateChatGroupState();
}

class _CreateChatGroupState extends State<CreateChatGroup> {
  final DashboardDataController _controller =
      Get.put(DashboardDataController());

  @override
  void initState() {
    getUserFromContacts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            backPressed();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: backPressed,
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }

  Future<List<User>> getUserFromContacts() async {
    List<User> listUsers = [];

    List<String> contactsNumbers = await getContactDetail();

    await ApiClient().searchUserFromPhoneContacts(accessToken: _controller.dashboardDataModal.value.accessToken!, contacts:contactsNumbers);

    return listUsers;
  }

  Future<List<String>> getContactDetail() async {
    List<String> sanitizeNumber = [];
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts();
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: false);

      List<Contact> contactList = [];
      for (int i = 0; i < contacts.length; i++) {
        contactList.add(contacts[i]);
      }

      List<String> contactNumbers = [];
      for (int i = 0; i < contactList.length; i++) {
        for (int j = 0; j < contactList[i].phones.length; j++) {
          contactNumbers.add(contactList[i].phones[j].number.toString());
        }
      }

      var seen = Set<String>();
      List<String> uniquelist =
          contactNumbers.where((contact) => seen.add(contact)).toList();
      for (int i = 0; i < uniquelist.length; i++) {
        uniquelist[i] = uniquelist[i]
            .replaceAll("-", "")
            .replaceAll("!", "")
            .replaceAll("'", "")
            .replaceAll(",", "")
            .replaceAll("_", "")
            .replaceAll("+", "")
            .replaceAll("(", "")
            .replaceAll(")", "")
            .replaceAll(" ", "");
      }
      sanitizeNumber = sanitizePhoneNumberString(uniquelist);
      return sanitizeNumber;
    }
    return sanitizeNumber;
  }

  List<String> sanitizePhoneNumberString(List<String> phoneNumbers) {
    List<String> sanitizePhoneNumberList = [];
    for (int i = 0; i < phoneNumbers.length; i++) {
      String reverseNumber = reverseStringUsingCodeUnits(phoneNumbers[i]);
      if (reverseNumber.length >= 10) {
        String filterNumber = reverseNumber.substring(0, 10);
    if(_controller.dashboardDataModal.value.contactNumber!=null){
      if(reverseStringUsingCodeUnits(_controller.dashboardDataModal.value.contactNumber!)!=filterNumber){
        sanitizePhoneNumberList.add(reverseStringUsingCodeUnits(filterNumber));
      }
    }
      }
    }
    print(sanitizePhoneNumberList);
    return sanitizePhoneNumberList;
  }

  String reverseStringUsingCodeUnits(String input) {
    return String.fromCharCodes(input.codeUnits.reversed);
  }

  Future<bool> backPressed() async {
    Get.back();
    return true;
  }
}

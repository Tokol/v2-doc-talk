import 'package:doc_talk/networks/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/dashboard_data_controller.dart';
import '../../../../models/otp_verification.dart';
import 'group/group_screen.dart';

class CreateChatGroup extends StatefulWidget {
  bool fromChatSetting;
  CreateChatGroup({this.fromChatSetting=false});

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

  bool loading = false;
  @override
  Widget build(BuildContext context) {
      return WidgetHUD(
        showHUD: loading,
        builder: (context) => Scaffold(
        body: WillPopScope(
          onWillPop: backPressed,
        child: GroupScreen(fromChatSetting: widget.fromChatSetting,),
        ),
      ),
    );
  }

  Future<List<ContactUserInApp>> getUserFromContacts() async {

    List<ContactUserInApp> contactUserInAp= [];

    List<String> contactsNumbers = await getContactDetail();

   var response =  await ApiClient().searchUserFromPhoneContacts(accessToken: _controller.dashboardDataModal.value.accessToken!, contacts:contactsNumbers);

   var contactData = response["data"];


   if(widget.fromChatSetting){
     for(int i=0; i<contactData.length; i++){
       bool alreadyInGroup=false;
      for (int j=0; j<_controller.totalUserInGroups.length;j++){

       if( _controller.totalUserInGroups[j].contactNumber.toString() == contactData[i]["contact_number"].toString()){
        alreadyInGroup = true;
       }
      }


       contactUserInAp.add(ContactUserInApp(
         contactNumber:  contactData[i]["contact_number"].toString(),
         userId: contactData[i]["_id"].toString(),
         fullName: contactData[i]["name"].toString(),
         img: contactData[i]["img"].toString(),
         email:contactData[i]["email"].toString(),

         speciality: contactData[i]["speciality"].toString(),
         selected: false,
         alreadyInGroup: alreadyInGroup,
       ));


     }
   }

   else {
     for(int i=0; i<contactData.length; i++){
       contactUserInAp.add(ContactUserInApp(
         contactNumber:  contactData[i]["contact_number"].toString(),
         userId: contactData[i]["_id"].toString(),
         fullName: contactData[i]["name"].toString(),
         img: contactData[i]["img"].toString(),
         email:contactData[i]["email"].toString(),

         speciality: contactData[i]["speciality"].toString(),
         selected: false,
       ));

     }


   }

   _controller.updateChatGroupContacts(contactUserInAp);
   setState(() {
     loading = false;
   });
    return contactUserInAp;
  }

  Future<List<String>> getContactDetail() async {
    List<String> sanitizeNumber = [];
    if (await FlutterContacts.requestPermission()) {
      setState(() {
        loading = true;
      });


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

class ContactUserInApp{
  String userId="";
  String fullName="";
  String img="";
  String speciality="";
  String email = "";
  bool selected = false;
  String contactNumber = "";
  bool alreadyInGroup;
  ContactUserInApp({ required this.contactNumber, required this.email, required this.userId, required this.fullName,required this.speciality,required this.img,this.selected=false, this.alreadyInGroup = false});

}

import 'package:doc_talk/helper/jsonfilters.dart';
import 'package:doc_talk/networks/api_client.dart';
import 'package:doc_talk/ui/dasboard/group/widgets/gridview_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../controller/dashboard_data_controller.dart';
import '../../../../../helper/utils.dart';
import '../../../../../models/chat_group_modal.dart';
import '../../../../../widgets/grid_items.dart';
import '../../../dashboard_home.dart';
import '../chat_screens/chat_home.dart';
import '../create_chat_group.dart';


class GroupAddScreen extends StatefulWidget {
  @override
  State<GroupAddScreen> createState() => _GroupAddScreenState();
}

class _GroupAddScreenState extends State<GroupAddScreen> {
  final DashboardDataController _controller =
  Get.put(DashboardDataController());


  String groupName="Health Care Hospital";

  bool loading = false;
  // WidgetHUD(
  // showHUD: loading,
  @override
  Widget build(BuildContext context) {
    return WidgetHUD(
      showHUD: loading,
        builder: (context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            "New Group",
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        body: Stack(children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 30, right: 30, bottom: 30),
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          groupName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Health Care Hospital',
                      ),
                    ),
                  ),
            Obx(()=> RichText(
                    text:  TextSpan(
                        text: 'Participants: ',
                        style: TextStyle(
                            color: const Color(0xFF5A227E), fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                            text: ('${totalParticipants()}'),
                            style: TextStyle(
                                color: const Color(0xFF5A227E), fontSize: 18),

                            // navigate to desired screen
                          )
                        ]),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child:  Obx(()=>GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 4,
                        ),
                        itemCount:_controller.chatGroupContact.length,
                        itemBuilder: (BuildContext ctx, index) {
                           if(_controller.chatGroupContact[index].selected){
                             return GridviewItem(
                                 name: _controller.chatGroupContact[index].fullName,
                                 onPress: (){
                                    setState(() {
                                      _controller.updateSelectedUserFromContact(index);
                                    });


                                 },
                                 imageUrl: _controller.chatGroupContact[index].img);

                           }

                            else {
                            return Visibility(
                                visible: true,
                                child: SizedBox(height: 0,width: 0,));
                          }


                        })),
                  ),
                ],
              ),
            ),
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
          ),
          Positioned(
            top: 60,
            right: 0,
            left: 0,
            child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  shape: BoxShape.circle,
                  color: const Color(0xFF5A227E),
                ),
                child: Center(
                  child: Text(
                    Utils.getShortCutOfString(
                      longValue: groupName,
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                )),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF5A227E),
          onPressed: () async {

            if(groupName=="Health Care Hospital"){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Group Name is Empty'),
                backgroundColor: Colors.red.shade300,
              ));
            }

            else{
              setState(() {
                loading = true;
              });
            var response =   await ApiClient().createChatGroup(groupName: groupName, accessToken: _controller.dashboardDataModal.value.accessToken!, contactNumber: _controller.dashboardDataModal.value.contactNumber!);


          ChatGroupModel chatGroupModel =   JsonFilters().getChatGroupModelFromCreateGroup(response, contactNumber: _controller.dashboardDataModal.value.contactNumber!, groupName: groupName);




              bool creatingFromContacts = false;
            try{
                String userGroupId = response["data"]["_id"];
                for (int i=0; i<_controller.userChatGroups.length; i++){
                  if(_controller.chatGroupContact[i].selected){
                    creatingFromContacts = true;
                      await ApiClient().addUserInGroup(groupId: userGroupId, accessToken: _controller.dashboardDataModal.value.accessToken!, contactNumber: _controller.chatGroupContact[i].contactNumber);

                  }

                }

            }

            catch(e){

            }

            setState(() {
            loading = false;
            });
              Get.close(2);
              Get.to(ChatHomeScreen(chatGroupModel: chatGroupModel,creatingFromContacts: creatingFromContacts,));


            }

          },
          child: Icon(FontAwesomeIcons.check),
        ),
      ),
    );
  }

  int totalParticipants(){
    int participants = 0;

    for(int i=0; i<_controller.chatGroupContact.length; i++){
      if(_controller.chatGroupContact[i].selected){
        participants++;
      }
    }
    return participants;

  }




}


/*


* flutter: 62406abe76e9240016026624
* */
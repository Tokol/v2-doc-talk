import 'package:doc_talk/helper/utils.dart';
import 'package:doc_talk/networks/api_client.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../controller/dashboard_data_controller.dart';
import '../../../../../models/patient_model.dart';

class ChatGroupActivePatientList extends StatefulWidget {
  String chatGroupId;


  ChatGroupActivePatientList({required this.chatGroupId});

  @override
  State<ChatGroupActivePatientList> createState() =>
      _ChatGroupActivePatientListState();
}

class _ChatGroupActivePatientListState
    extends State<ChatGroupActivePatientList> {
  final DashboardDataController _controller =
      Get.put(DashboardDataController());

  List<Patient> patientList = [];

  bool loading = true;

  @override
  void initState() {
    getPatientList();

    super.initState();
  }

  Future<void> getPatientList() async {
    loading =true;
    patientList = await ApiClient().getPatientFromGroup(
        accessToken: _controller.dashboardDataModal.value.accessToken,
        groupId: widget.chatGroupId);

    print(patientList.length);

    setState(() {
       loading =false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading?Text('Loading..'):ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: patientList.length,
        itemBuilder: (context, item) {
          return Card(
            elevation: 30.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 250,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 5.0,),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('${patientList[item].firstName.toString().toCapitalized()} ${patientList[item].middleName.toString().toCapitalized()} ${patientList[item].lastName.toString().toCapitalized()}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                      ),
                    ),

                    SizedBox(height: 5.0,),

                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(

                        children: [
                          Flexible(

                            child: Text('Bed No: ${patientList[item].bedNo}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 14.0,color: Theme.of(context).primaryColor),),
                          ),

                          Container(margin: EdgeInsets.symmetric(horizontal: 5.0), height: 15, width: 1, color: Colors.black,),



                          Flexible(

                            child: Text('Ward : ${patientList[item].wardNo}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 14.0,color: Theme.of(context).primaryColor),),
                          ),




                        ],),
                    ),

                    SizedBox(height: 4.0,),

                    Center(
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),

                          child: Text('Last Update', style: TextStyle(color: Colors.white, fontSize: 10.0),),
                        )),

                    Expanded(

                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color:Theme.of(context).primaryColor,
                        child: Row(children: [

                          SizedBox(width: 3.0,),

                          Icon(Icons.watch_later,color: Colors.white,
                            size: 14.0,
                          ),

                          SizedBox(width: 3.0,),
                          Container(
                            child: Text('${patientList[item].lastUpdateAt}',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 11.0, color: Colors.white,),
                            ),
                          ),

                          SizedBox(width: 4.0,),
                          Icon(FontAwesomeIcons.stethoscope,color: Colors.white,
                            size: 12.0,
                          ),


                          SizedBox(width: 5.0,),
                          Flexible(

                            child: Text('${patientList[item].lastUpdateBy}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 11.0, color: Colors.white,),
                              maxLines: 1,
                            ),
                          )


                        ],),
                      ),
                    )

                  ]
              ),
            ),
          );
        },
      ),
    );
  }
}

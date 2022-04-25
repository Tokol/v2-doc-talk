import 'package:doc_talk/ui/dasboard/patient/patient_widget/row_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/patient_controller.dart';
import '../patient.dart';

class GlassGlowComaScale extends StatelessWidget {
  final PatientController _patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
      title: Text("Glasgow Coma Scale"),
      childrenPadding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      children: [
        RowListItem(
          isTitle: true,
          firstChild: Text(
            "Behavior",
            style: TextStyle(color: Colors.white),
          ),
          secondChild: Text(
            "Score",
            style: TextStyle(color: Colors.white),
          ),
          thirdChild: Text(
            "Remark",
            style: TextStyle(color: Colors.white),
          ),
        ),
        RowListItem(
            isTitle: false,
            firstChild:
            customCard(context, 'assets/images/glasgoweye.png', "Eye opening response"),
            secondChild: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _patientController.glasgowComaScale.value.eyeOpeningResponseValue,
                    onChanged: (value){
                      _patientController.glasgowComaScale.value.eyeOpeningResponseValue = value;
                      _patientController.updateFlagGCS(true);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10.0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                      hintText: "Value",
                    ),
                  ),
                )

              ],
            ),
            thirdChild: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _patientController.glasgowComaScale.value.eyeOpeningResponseRemark,
                  onChanged: (value){
                    _patientController.glasgowComaScale.value.eyeOpeningResponseRemark = value;
                    _patientController.updateFlagGCS(true);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.0, top: 10.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor,),
                    hintText: "Remark",
                  ),
                ),
              ],
            )),
        RowListItem(
            isTitle: false,
            firstChild:
            customCard(context, 'assets/images/glasgowmouth.png', "Verbal Response"),
            secondChild: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _patientController.glasgowComaScale.value.verbalResponseValue,
                  onChanged: (value){
                    _patientController.glasgowComaScale.value.verbalResponseValue = value;
                    _patientController.updateFlagGCS(true);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    hintText: "Value",
                  ),
                ),


              ],
            ),
            thirdChild: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _patientController.glasgowComaScale.value.verbalResponseRemark,
                  onChanged: (value){
                    _patientController.glasgowComaScale.value.verbalResponseRemark = value;
                    _patientController.updateFlagGCS(true);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.0, top: 10.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor,),
                    hintText: "Remark",
                  ),
                ),
              ],
            )),
        RowListItem(
            isTitle: false,
            firstChild:
            customCard(context, 'assets/images/glasgowmotar.png', "Motor Response"),
            secondChild: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _patientController.glasgowComaScale.value.motorResponseValue,
                  onChanged: (value){
                    _patientController.glasgowComaScale.value.motorResponseValue = value;
                    _patientController.updateFlagGCS(true);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    hintText: "Value",
                  ),
                ),

              ],
            ),
            thirdChild: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _patientController.glasgowComaScale.value.motorResponseRemark,
                  onChanged: (value){
                    _patientController.glasgowComaScale.value.motorResponseRemark = value;
                    _patientController.updateFlagGCS(true);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15.0, top: 10.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor,),
                    hintText: "Remark",
                  ),
                ),


              ],
            ))
      ],
    );
  }
}
Widget customCard(BuildContext context, String iconData, String title) {



  return Padding(
    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 40,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(5.0),

                  decoration: BoxDecoration(color: Color(0xFF5A227E)),
                  child: Image(image: AssetImage(iconData),
                  height: 20,
                    width: 20,
                  )),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
          ],
        )),
  );
}
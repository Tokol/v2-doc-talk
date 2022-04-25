import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/patient_controller.dart';

class PatientImagingList extends StatefulWidget {
  @override
  State<PatientImagingList> createState() => _PatientImagingListState();
}

class _PatientImagingListState extends State<PatientImagingList> {
  final PatientController _patientController = Get.put(PatientController());

  List<Widget> renderList(BuildContext context){
    List<Widget> imagingList = [

    ];

    for(int i=0; i<_patientController.patientImagingList.length;i++){
      imagingList.add(

          Card(
            elevation: 15.0,
            shadowColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),

        padding: EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              SizedBox(width: 5,),
              Text(_patientController.patientImagingList[i].title, textAlign: TextAlign.center,),
              IconButton(onPressed: (){
              setState(() {
                _patientController.patientImagingList.removeAt(i);
              });


              }, icon: Icon(Icons.delete)),


            ],),
              Image(
                height: 200,
                width: 200,
                image: FileImage(File(_patientController.patientImagingList[i].image!.path)),),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(_patientController.patientImagingList[i].remark, textAlign: TextAlign.center,)),

            ],
        ),


      ),
          ));
    }
    imagingList.add(Container(height: 100,));

    return imagingList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: renderList(context),
          ),
        ),
      ),);

  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../controller/patient_controller.dart';
import '../../../../models/patient_model.dart';
import '../../../../widgets/cupertino_modal.dart';
import '../../dashbaordPages/profile/widgets/bottom_modal.dart';
import '../../dashbaordPages/profile/widgets/buttom_icon_bottom.dart';
import '../patient.dart';

enum IMAGESOURCE { CAMERA, GALLERY }

class PatientImaging extends StatelessWidget {
  final PatientController _patientController = Get.put(PatientController());

  List<String> imagingType = ["XRAY", "USG", "CT", "MRI", "OTHER"];

  List<Widget> fillWidgets(BuildContext context) {
    List<Widget> fillWidgets = [];
    for (int i = 0; i < imagingType.length; i++) {
      fillWidgets.add(Container(
        margin: EdgeInsets.only(right: 10.0),
        child: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Color(0xFF5A227E),
            ),
            child: Text(imagingType[i]),
            onPressed: () {
              bottomModal(
                  height: 150,
                  context: context,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        height: 150,
                        child: Column(
                          children: <Widget>[
                            BottomIconButton(
                              onPressed: () {
                                addImage(context, imagingType[i],
                                    IMAGESOURCE.CAMERA);
                              },
                              icon: Icons.photo_camera,
                              title: 'Take photo from Camera',
                            ),
                            BottomIconButton(
                              onPressed: () {
                                addImage(context, imagingType[i],
                                    IMAGESOURCE.GALLERY);
                              },
                              icon: Icons.photo,
                              title: 'Take photo from Image Gallery',
                            ),
                          ],
                        ),
                      );
                    },
                  ));
            }),
      ));
    }
    return fillWidgets;
  }

  addImage(BuildContext context, String title, IMAGESOURCE imageSource) async {
    String remark="";

    final ImagePicker _picker = ImagePicker();
    XFile? image;
    imageSource == IMAGESOURCE.CAMERA
        ? image = await _picker.pickImage(source: ImageSource.camera)
        : image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (image != null && image != "") {
        Navigator.pop(context);
        print(image!.path);

        showMaterialModalBottomSheet(
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          isDismissible: false,
          builder: (context) {
            //PhotoShareBottomSheet()
            return Material(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.amber,
                  automaticallyImplyLeading: false,
                  title: Text('Add File'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                body: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.0,),
                        Text(title, style: TextStyle(fontSize: 28.0, color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 20.0,),

                        Image(
                          height: 200,
                          width: 200,
                          image: FileImage(File(image!.path)),),

                        SizedBox(height: 20.0,),


                                          PatientText(
                        title: "Remark",
                        hintText:
                        "Provide remark here",

                        onChanged: (value){
                           remark = value;

                        },
                        isRequired: false),


                        ElevatedButton(onPressed: (){

                          PatientImagingModal _patientImagingModal = PatientImagingModal();
                          _patientImagingModal.image = image;
                          _patientImagingModal.title = title;
                          _patientImagingModal.remark = remark.toString();
                          _patientController.addPatientImaging(_patientImagingModal);
                          Navigator.pop(context);

                        }, child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text('Add'),

                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 10.0,
                          primary: Theme.of(context).primaryColor,
                        ),
                        ),



                      ],
                    ),
                  ),
                ),

              ),
            );
          },
        );


      } else {
        print('ok');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: fillWidgets(context),
            ),
          ),
        ),
      ],
    );
  }
}

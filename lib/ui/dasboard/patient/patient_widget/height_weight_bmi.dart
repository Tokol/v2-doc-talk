import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/patient_controller.dart';

class HeightWeightBmiWidget extends StatelessWidget {

  final PatientController _patientController = Get.put(PatientController());
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            width: 1000,
            height: 250,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Table(

                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),

                    },
                    border: TableBorder.all(),
                    // Allows to add a border decoration around your table
                    children: [

                      heightWeightBmi(
                        context: context,
                        title: 'Height ',
                        value: _patientController.heightWeightBmi.value.height,
                        onChangeValue: (value){
                          _patientController.heightWeightBmi.value.height=value;
                          _patientController.updateFlagWeightBmi(true);
                        },


                        icon: Icon(FontAwesomeIcons.user),
                      ),



                      heightWeightBmi(
                        context: context,
                        title: 'Weight ',
                        value: _patientController.heightWeightBmi.value.weight,
                        onChangeValue: (value){
                          _patientController.heightWeightBmi.value.weight=value;
                          _patientController.updateFlagWeightBmi(true);
                        },


                        icon: Icon(FontAwesomeIcons.weightHanging),
                      ),


                      heightWeightBmi(
                        context: context,
                        title: 'BMI ',
                        value: _patientController.heightWeightBmi.value.bmi,
                        onChangeValue: (value){
                          _patientController.heightWeightBmi.value.bmi=value;
                          _patientController.updateFlagWeightBmi(true);
                        },


                        icon: Icon(FontAwesomeIcons.weightScale),
                      ),

                    ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow heightWeightBmi({required BuildContext context, required String title, required Icon icon, required Function(String) onChangeValue, required String value} ){

    return  TableRow(
        children: [
          TableCell(
            child: Container(
              margin:EdgeInsets.only(top: 15.0),
              child: icon,
            ),
          ),
          TableCell(
            child: Padding(
              padding:
              EdgeInsets.only(left: 8.0),
              child: Container(
                margin:EdgeInsets.only(top: 18.0),
                child: Text(
                  title,

                  style: TextStyle(
                    color: Color(
                        0xFF5A227E),
                  ),
                ),
              ),
            ),
          ),
          TableCell(
            child: Padding(
                padding:
                EdgeInsets.all(
                    8.0),
                child:
                TextFormField(
                  initialValue: value,
                  onChanged: onChangeValue,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(right:15.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                    hintText: "Value",
                  ),
                )


            ),
          ),

        ]);
  }

}

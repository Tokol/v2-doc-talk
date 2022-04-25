
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/patient_controller.dart';

enum generalExamType  {
  pallor,icterus,lymphedenopathy,cyanosis,clubbing,oedema,dehydration_hydration
}

class GeneralExaminationWidget extends StatelessWidget {

  final PatientController _patientController = Get.put(PatientController());


  @override
  Widget build(BuildContext context) {
    print(_patientController.generalExamination.value.pallorSelected);
  //_patientController.generalExamination
    return ExpansionTile(
      title: Text("PILCCOD"),
      children: [
        DataTable(
            columnSpacing: 20.0,
            border: TableBorder.all(), columns: [
          DataColumn(label: Text('')),
          DataColumn(
              label: Text(
                'Yes/No',
                style: TextStyle(
                  color: Color(0xFF5A227E),
                  fontWeight: FontWeight.w700,
                ),
              )),
          DataColumn(
              label: Text(
                'Remarks',
                style: TextStyle(
                  color: Color(0xFF5A227E),
                  fontWeight: FontWeight.w700,
                ),
              )),
        ], rows: [
          DataRow(cells: [
            DataCell(Text('P')),
            DataCell(
              GeneralExaminationRadioDemo(examType: generalExamType.pallor,),

            ),

            DataCell(
              TextFormField(
                initialValue: _patientController.generalExamination.value.pallorRemark,
                onChanged: (value){
                  _patientController.generalExamination.value.pallorRemark = value;
                  _patientController.updateFlagPiccod(true);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,

               decoration: InputDecoration(
                 contentPadding: EdgeInsets.only(right:15.0),
                 hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                 hintText: "Provide remark here",
               ),
              ),


            ),
          ]),
          DataRow(cells: [
            DataCell(Text('I')),
            DataCell(
              GeneralExaminationRadioDemo(examType: generalExamType.icterus,),
            ),
            DataCell(
              TextFormField(
                initialValue: _patientController.generalExamination.value.icterusRemark,
                onChanged: (value){
                  _patientController.generalExamination.value.icterusRemark = value;

                  _patientController.updateFlagPiccod(true);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right:15.0),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintText: "Provide remark here",
                ),
              ),


            ),
          ]),
          DataRow(cells: [
            DataCell(Text('L')),
            DataCell(
              GeneralExaminationRadioDemo(examType: generalExamType.lymphedenopathy,),
            ),
            DataCell(

              TextFormField(
                initialValue: _patientController.generalExamination.value.lymphedenopathyRemark,
                onChanged: (value){
                  _patientController.generalExamination.value.lymphedenopathyRemark = value;
                  _patientController.updateFlagPiccod(true);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right:15.0),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintText: "Provide remark here",
                ),
              ),
            ),
          ]),
          DataRow(cells: [
            DataCell(Text('C')),
            DataCell(
              GeneralExaminationRadioDemo(examType: generalExamType.cyanosis),
            ),
            DataCell(
              TextFormField(
                initialValue: _patientController.generalExamination.value.cyanosisRemark,
                onChanged: (value){
                  _patientController.generalExamination.value.cyanosisRemark = value;
                  _patientController.updateFlagPiccod(true);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right:15.0),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintText: "Provide remark here",
                ),
              ),

            ),
          ]),

          DataRow(cells: [
            DataCell(
              Text('C'),
            ),
            DataCell(
              GeneralExaminationRadioDemo(examType: generalExamType.clubbing,),
            ),
            DataCell(
              TextFormField(
                initialValue: _patientController.generalExamination.value.clubbingRemark,
                onChanged: (value){
                  _patientController.generalExamination.value.clubbingRemark = value;
                  _patientController.updateFlagPiccod(true);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right:15.0),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintText: "Provide remark here",
                ),
              ),

            ),
          ]),
          DataRow(cells: [
            DataCell(
              Text('O'),
            ),
            DataCell(
              GeneralExaminationRadioDemo(examType: generalExamType.oedema,),
            ),
            DataCell(
              TextFormField(
                initialValue: _patientController.generalExamination.value.oedemaRemark,
                onChanged: (value){
                  _patientController.generalExamination.value.oedemaRemark = value;
                  _patientController.updateFlagPiccod(true);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right:15.0),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintText: "Provide remark here",
                ),
              ),

            ),
          ]),
          DataRow(cells: [
            DataCell(
              Text('D'),
            ),
            DataCell(
              GeneralExaminationRadioDemo(examType: generalExamType.dehydration_hydration,),
            ),
            DataCell(
              TextFormField(
                initialValue: _patientController.generalExamination.value.dehydration_hydrationRemark,
                onChanged: (value){
                  _patientController.generalExamination.value.dehydration_hydrationRemark = value;
                  _patientController.updateFlagPiccod(true);
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right:15.0),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  hintText: "Provide remark here",
                ),
              ),),
          ]),
        ]),
      ],
    );
  }
}

class GeneralExaminationRadioDemo extends StatefulWidget {

  final Function(String)? onChanged;
   String? status;
   generalExamType? examType;

  GeneralExaminationRadioDemo({this.onChanged,this.status,this.examType });
  @override

  State createState() => _GeneralExaminationRadioDemoState();
}
class _GeneralExaminationRadioDemoState extends State<GeneralExaminationRadioDemo> {
  final PatientController _patientController = Get.put(PatientController());



  String? _groupValue="True";


  @override
  void initState() {
    filterGroupName();
    super.initState();
  }

  filterGroupName(){
    switch(widget.examType){
      case generalExamType.pallor:

    }
  }

  updateData(String value){
    _patientController.updateFlagPiccod(true);
    if(widget.examType==generalExamType.pallor){
      setState(() {
        _patientController.generalExamination.value.pallorSelected=value;
      });

    }

    if(widget.examType==generalExamType.icterus) {
      setState(() {
        _patientController.generalExamination.value.icterusSelected = value;
      });
    }

      if(widget.examType==generalExamType.lymphedenopathy) {
        setState(() {
          _patientController.generalExamination.value.lymphedenopathySelected =
              value;
        });
      }
        if(widget.examType==generalExamType.cyanosis) {
          setState(() {
            _patientController.generalExamination.value.cyanosisSelected =
                value;
          });
        }

          if (widget.examType == generalExamType.clubbing) {
            setState(() {
              _patientController.generalExamination.value.clubbingSelected =
                  value;
            });
          }

            if (widget.examType == generalExamType.oedema) {
              setState(() {
                _patientController.generalExamination.value.oedemaSelected =
                    value;
              });
            }
              if (widget.examType == generalExamType.dehydration_hydration) {
                setState(() {
                  _patientController.generalExamination.value
                      .dehydration_hydrationSelected = value;
                });
              }
            }


            Color? getColor(String value) {
              setState(() {

              });
              switch (widget.examType) {
                case generalExamType.pallor:
                  if (_patientController.generalExamination.value
                      .pallorSelected == value) {
                    return Colors.cyan;
                  }
                  return Colors.white;

                case generalExamType.icterus:
                  if (_patientController.generalExamination.value
                      .icterusSelected == value) {
                    return Colors.cyan;
                  }
                  return Colors.white;


                case generalExamType.lymphedenopathy:
                  if (_patientController.generalExamination.value
                      .lymphedenopathySelected == value) {
                    return Colors.cyan;
                  }
                  return Colors.white;


                case generalExamType.cyanosis:
                  if (_patientController.generalExamination.value
                      .cyanosisSelected == value) {
                    return Colors.cyan;
                  }
                  return Colors.white;


                case generalExamType.clubbing:
                  if (_patientController.generalExamination.value
                      .clubbingSelected == value) {
                    return Colors.cyan;
                  }
                  return Colors.white;


                case generalExamType.oedema:
                  if (_patientController.generalExamination.value
                      .oedemaSelected == value) {
                    return Colors.cyan;
                  }
                  return Colors.white;


                case generalExamType.dehydration_hydration:
                  if (_patientController.generalExamination.value
                      .dehydration_hydrationSelected == value) {
                    return Colors.cyan;
                  }
                  return Colors.white;

                default:
                  return Colors.white;
              }
            }

            @override
            Widget build(BuildContext context) {
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        updateData("True");
                        setState(() {

                        });
                      },
                      splashColor: Colors.cyan.withOpacity(0.5),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: ShapeDecoration(
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                color: getColor("True"),
                              ),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        updateData("False");
                        setState(() {

                        });
                      },
                      splashColor: Colors.cyan.withOpacity(0.5),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: ShapeDecoration(
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                color: getColor("False"),
                              ),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              );
            }
          }

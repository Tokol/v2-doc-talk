import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controller/patient_controller.dart';

class PatientVitals extends StatelessWidget {
  final PatientController _patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            width: 1000,
            height: 500,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                    },
                    border: TableBorder.all(),
                    // Allows to add a border decoration around your table
                    children: [
                      vitalRow(
                        context: context,
                        title: 'Blood Pressure',
                        value:
                            _patientController.vitals.value.bloodPressureValue,
                        remark:
                            _patientController.vitals.value.bloodPressureRemark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.bloodPressureValue =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController.vitals.value.bloodPressureRemark =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.stethoscope),
                      ),
                      vitalRow(
                        context: context,
                        title: 'Pulse',
                        value: _patientController.vitals.value.pulseValue,
                        remark: _patientController.vitals.value.pulseRemark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.pulseValue = value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController.vitals.value.pulseRemark = value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.heartPulse),
                      ),
                      vitalRow(
                        context: context,
                        title: 'Respiratory Rate ',
                        value: _patientController
                            .vitals.value.respiratoryRateValue,
                        remark: _patientController
                            .vitals.value.respiratoryRateRemark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.respiratoryRateValue =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController
                              .vitals.value.respiratoryRateRemark = value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.heartCircleCheck),
                      ),
                      vitalRow(
                        context: context,
                        title: 'Body Temperature',
                        value: _patientController
                            .vitals.value.bodyTemperatureValue,
                        remark: _patientController
                            .vitals.value.bodyTemperatureRemark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.bodyTemperatureValue =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController
                              .vitals.value.bodyTemperatureRemark = value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.temperatureEmpty),
                      ),
                      vitalRow(
                        context: context,
                        title: 'SPO2',
                        value: _patientController.vitals.value.spo2Value,
                        remark: _patientController.vitals.value.spo2Remark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.spo2Value = value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController.vitals.value.spo2Remark = value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.squarePlus),
                      ),
                      vitalRow(
                        context: context,
                        title: 'Urine Output',
                        value: _patientController.vitals.value.urineOutputValue,
                        remark:
                            _patientController.vitals.value.urineOutPutRemark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.urineOutputValue =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController.vitals.value.urineOutPutRemark =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.bottleWater),
                      ),
                      vitalRow(
                        context: context,
                        title: 'Total Intake',
                        value: _patientController.vitals.value.totalIntakeValue,
                        remark:
                            _patientController.vitals.value.totalIntakeValue,
                        onChangeValue: (value) {
                          _patientController.vitals.value.totalIntakeValue =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController.vitals.value.totalIntakeRemark =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.glassWater),
                      ),
                      vitalRow(
                        context: context,
                        title: 'Pain Scale',
                        value: _patientController.vitals.value.painScaleValue,
                        remark: _patientController.vitals.value.painScaleRemark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.painScaleValue =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController.vitals.value.painScaleRemark =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.scaleBalanced),
                      ),
                      vitalRow(
                        context: context,
                        title: 'Other Vitals',
                        value: _patientController.vitals.value.otherVitalValue,
                        remark:
                            _patientController.vitals.value.otherVitalRemark,
                        onChangeValue: (value) {
                          _patientController.vitals.value.otherVitalValue =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        onChangeRemark: (value) {
                          _patientController.vitals.value.otherVitalRemark =
                              value;
                          _patientController.updateFlagVitals(true);
                        },
                        icon: Icon(FontAwesomeIcons.file),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow vitalRow(
      {required BuildContext context,
      required String title,
      required Icon icon,
      required Function(String) onChangeValue,
      required String value,
      required String remark,
      required Function(String) onChangeRemark}) {
    return TableRow(children: [
      TableCell(
        child: Container(
          margin: EdgeInsets.only(top: 15.0),
          child: icon,
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Container(
            margin: EdgeInsets.only(top: 18.0),
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xFF5A227E),
              ),
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: value,
              onChanged: onChangeValue,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(right: 15.0),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                hintText: "Value",
              ),
            )),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: remark,
            onChanged: onChangeRemark,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(right: 15.0),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Theme.of(context).primaryColor),
              hintText: "Remark",
            ),
          ),
        ),
      ),
    ]);
  }
}

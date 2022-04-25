import 'package:doc_talk/ui/dasboard/patient/patien_func.dart';
import 'package:doc_talk/ui/dasboard/patient/patient_widget/general_examination.dart';
import 'package:doc_talk/ui/dasboard/patient/patient_widget/glasgow_coma_scale.dart';
import 'package:doc_talk/ui/dasboard/patient/patient_widget/height_weight_bmi.dart';
import 'package:doc_talk/ui/dasboard/patient/patient_widget/patie_imaging_list.dart';
import 'package:doc_talk/ui/dasboard/patient/patient_widget/patient_imaging.dart';
import 'package:doc_talk/ui/dasboard/patient/patient_widget/patient_vitals.dart';
import 'package:doc_talk/ui/dasboard/patient/patient_widget/row_list.dart';
import 'package:doc_talk/widgets/action_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../controller/patient_controller.dart';
import '../../../models/diagnosis_model.dart';
import '../../../models/patient_model.dart';

class PatientAdd extends StatelessWidget {
  final bool updatePatient;
  final String roomId;
  final Patient? patientData;

  final PatientController _patientController = Get.put(PatientController());
  Patient _patient = Patient();
  bool loading = false;

  PatientAdd({this.updatePatient = false, this.patientData, required this.roomId}) {
    if (this.updatePatient == false) {
      _patient.resetPatientData();
      _patientController.updatePatientData(_patient);
    } else {
      _patient = this.patientData!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return WidgetHUD(
      showHUD: loading,
      builder: (context)=>Scaffold(
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
            updatePatient == false ? "Add a new Patient" : "Update a patient",
            style: TextStyle(fontSize: 22.0),
          ),
          actions: [
            updatePatient == false
                ? IconButton(
                icon: Icon(FontAwesomeIcons.check),
                onPressed: ()  async {
                  var validate = _patientController.patient.value.isValid();
                  if (validate.containsKey(false)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(validate[false]!),
                      backgroundColor: Colors.red.shade300,
                    ));
                  } else {
                    //TODO
                    await addNewPatient(roomId);

                    if(_patientController.patient.value.id!=""){
                      await updateSynopsis();
                      await _patientController.reset();

                    }

                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('IP Number conflict with previous patient, please change Ip number '),
                        backgroundColor: Colors.red.shade300,
                      ));
                    }





                  }
                })
                : IconButton(
                icon: Icon(FontAwesomeIcons.penToSquare),
                onPressed: () async {
                  var validate = _patientController.patient.value.isValid();
                  if (validate.containsKey(false)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(validate[false]!),
                      backgroundColor: Colors.red.shade300,
                    ));
                  } else {
                    await updatePatientProfile();
                    await updateSynopsis();
                    await _patientController.reset();


                  }
                })
          ],
        ),
        body: GestureDetector(

            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },


            child: PatientAddScreen()),
      )

    );
  }
}


class PatientAddScreen extends StatefulWidget {
  @override
  State<PatientAddScreen> createState() => _PatientAddScreen();
}

class _PatientAddScreen extends State<PatientAddScreen> {
  final PatientController _patientController = Get.put(PatientController());

  bool _value = false;
  int val = -1;
  bool _customTileExpanded = false;
  bool genderSelect = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  bool _isContainerVisible = false;
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        //backgroundColor:  Color(0xFF5A227E),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Text(
                          "General Information",
                          style: TextStyle(
                              color: Color(0xFF5A227E),
                              fontWeight: FontWeight.w700),
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "First Name",
                                  initialValue: _patientController
                                      .patient.value.firstName!,
                                  isRequired: true,
                                  onChange: (value) {
                                    _patientController.patient.value.firstName =
                                        value;
                                  },
                                  hint: "First Name",
                                ),
                              ),
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Middle Name",
                                  initialValue: _patientController
                                      .patient.value.middleName!,
                                  isRequired: false,
                                  hint: "Middle Name",
                                  onChange: (value) {
                                    _patientController
                                        .patient.value.middleName = value;
                                  },
                                ),
                              ),
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Last Name",
                                  isRequired: false,
                                  initialValue: _patientController
                                      .patient.value.lastName!,
                                  hint: "Last Name",
                                  onChange: (value) {
                                    _patientController.patient.value.lastName =
                                        value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                            text: "Sex",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextSpan(
                                            text: "*",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF3EB16F)),
                                          ),
                                        ]),
                                      ),
                                      GenderRadioGroup(),
                                    ],
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Age",
                                  initialValue:
                                      _patientController.patient.value.age!,
                                  isRequired: true,
                                  hint: "00",
                                  onChange: (value) {
                                    _patientController.patient.value.age =
                                        value;
                                  },
                                ),
                              ),
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Contact",
                                  isRequired: false,
                                  hint: "+977-",
                                  onChange: (value) {
                                    _patientController
                                        .patient.value.contactNumber = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Address",
                                  initialValue:
                                      _patientController.patient.value.address!,
                                  isRequired: false,
                                  hint: "Address",
                                  onChange: (value) {
                                    _patientController.patient.value.address =
                                        value;
                                  },
                                ),
                              ),
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Occupation",
                                  initialValue: _patientController
                                      .patient.value.occupation!,
                                  isRequired: false,
                                  hint: "Occupation",
                                  onChange: (value) {
                                    _patientController
                                        .patient.value.occupation = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Admit Date",
                                  initialValue: _patientController
                                      .patient.value.admittedDate!,
                                  isRequired: true,
                                  hint: "Admit Date",
                                  onChange: (value) {
                                    _patientController
                                        .patient.value.admittedDate = value;
                                  },
                                ),
                              ),
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Bed NO",
                                  initialValue:
                                      _patientController.patient.value.bedNo!,
                                  isRequired: true,
                                  hint: "Bed NO",
                                  onChange: (value) {
                                    _patientController.patient.value.bedNo =
                                        value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Ward Name",
                                  initialValue:
                                      _patientController.patient.value.wardNo!,
                                  isRequired: false,
                                  hint: "Ward Name",
                                  onChange: (value) {
                                    _patientController.patient.value.wardNo =
                                        value;
                                  },
                                ),
                              ),
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "IP Number",
                                  initialValue: _patientController
                                      .patient.value.ipNumber!,
                                  isRequired: true,
                                  hint: "IP Number",
                                  onChange: (value) {
                                    _patientController.patient.value.ipNumber =
                                        value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Department",
                                  initialValue: _patientController
                                      .patient.value.department!,
                                  isRequired: false,
                                  hint: "Department",
                                  onChange: (value) {
                                    _patientController
                                        .patient.value.department = value;
                                  },
                                ),
                              ),
                              Expanded(
                                child: PanelTitle(
                                  tileValue: "Unit",
                                  isRequired: false,
                                  initialValue:
                                      _patientController.patient.value.unit!,
                                  hint: "Unit",
                                  onChange: (value) {
                                    _patientController.patient.value.unit =
                                        value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 15),
                        title: Text(
                          'Diagnosis',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                          Obx(() => DataTable(
                                columnSpacing: 25.0,
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color(0xFF5A227E)),
                                headingTextStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Diagnosis',
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Operation",
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Date",
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Action",
                                    style: TextStyle(fontSize: 10),
                                  )),
                                ],
                                rows: createRow(),
                              )),
                          Container(
                            //alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF5A227E),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  _showBottomOption(context, _nameController,
                                      _descController, _dateController);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        title: Text(
                          'Presenting Complain',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 20,),
                        children: [
                          PatientText(
                            hintText: 'provide presenting complain here',
                            initialValue: _patientController.patient.value.presentingComplains!,
                            onChanged:(value){
                              print(value);
                              _patientController.patient.value.presentingComplains =value;
                          },
                            isRequired: false,
                          )
                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Text(
                          'Patients History',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                          PatientText(
                            hintText:
                                'Provide your present illness history ',
                            title: 'History of Present Illness',
                            initialValue: _patientController.patient.value.hopi!,
                            onChanged:(value){
                              print(value);
                              _patientController.patient.value.hopi =value;
                            },
                            isRequired: false,
                          ),
                          PatientText(
                            hintText:
                                'Provide known medical history',
                            title: 'Known Medical History',
                            initialValue: _patientController.patient.value.knownMedicalHistory!,
                            onChanged:(value){
                              print(value);
                              _patientController.patient.value.knownMedicalHistory =value;
                            },
                            isRequired: false,
                          ),
                          PatientText(
                            hintText:
                                'Provide past history here',
                            title: 'Past History',
                            isRequired: false,
                            initialValue: _patientController.patient.value.pastHistory!,
                            onChanged:(value){
                              print(value);
                              _patientController.patient.value.pastHistory =value;
                            },
                          ),
                          PatientText(
                            hintText:
                                'Provide Menstrual History ',
                            title: 'Menstrual History',
                            initialValue: _patientController.patient.value.menstrualHistory!,
                            onChanged:(value){
                              _patientController.patient.value.menstrualHistory =value;
                            },
                            isRequired: false,
                          ),




                          PatientText(
                            hintText:
                            'Provide Obstetric History ',
                            title: 'Obstetric History',
                            initialValue: _patientController.patient.value.obstetricHistory!,
                            onChanged:(value){
                              _patientController.patient.value.obstetricHistory =value;
                            },
                            isRequired: false,
                          ),

                          PatientText(
                            hintText:
                            'Provide Family History ',
                            title: 'Family History',
                            initialValue: _patientController.patient.value.familyHistory!,
                            onChanged:(value){
                              _patientController.patient.value.familyHistory =value;
                            },
                            isRequired: false,
                          ),

                          PatientText(
                            hintText:
                            'Provide Socio Economic History ',
                            title: 'Socio Economic History',
                            initialValue: _patientController.patient.value.socioEconomicsHistory!,
                            onChanged:(value){
                              _patientController.patient.value.socioEconomicsHistory =value;
                            },
                            isRequired: false,
                          ),

                          PatientText(
                            hintText:
                            'provide Other Relevant History',
                            title: 'Other Relevant History',
                            initialValue: _patientController.patient.value.otherRelevantHistory!,
                            onChanged:(value){
                              _patientController.patient.value.otherRelevantHistory =value;
                            },
                            isRequired: false,
                          ),


                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        title: Text(
                          'General Examination',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                          GeneralExaminationWidget(),
                          ExpansionTile(
                              title: Text("VITALS"),
                              childrenPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              children: [
                                PatientVitals()
                              ]),

                          ExpansionTile(
                              title: Text("Height Weight BMI"),
                              childrenPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              children: [
                                HeightWeightBmiWidget()
                              ]),
                          GlassGlowComaScale(),
                          //systemAndOtherExam


                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: PatientText(
                              hintText:
                              'Systematic Local Examination',
                              title: 'Systematic Local Examination',
                              initialValue: _patientController.systemAndOtherExam.value.systematiclocalExaminationValue!,
                              onChanged:(value){
                                _patientController.systemAndOtherExam.value.systematiclocalExaminationValue =value;
                              },
                              isRequired: false,
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: PatientText(
                              hintText:
                              'Other Disease General Examination',
                              title: 'Other Disease General Examination',
                              initialValue: _patientController.systemAndOtherExam.value.otherExamValue!,
                              onChanged:(value){
                                _patientController.systemAndOtherExam.value.otherExamValue =value;
                              },
                              isRequired: false,
                            ),
                          ),

                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Text(
                          'Patient Assessment,Plan & Complain',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                          PatientText(
                              title: "Patient Assessment",
                              hintText:
                                  "Provide Patient Assessment here",
                              initialValue: _patientController.patientAssessmentPlan.value.patientAssessment,
                              onChanged: (value){
                                _patientController.patientAssessmentPlan.value.patientAssessment = value;
                              },
                              isRequired: false),
                          PatientText(
                              title: "Patient Plan",
                              hintText:
                                  "Provide Patient Plan here",
                              initialValue: _patientController.patientAssessmentPlan.value.patientPlan,
                              onChanged: (value){
                                _patientController.patientAssessmentPlan.value.patientPlan = value;
                              },
                              isRequired: false),
                          PatientText(
                              title: "Patient Issue and Complain",
                              hintText:
                                  "Provide Patient current Issue and Complain here",
                              initialValue: _patientController.patientAssessmentPlan.value.patientIssueAndComplain,
                              onChanged: (value){
                                _patientController.patientAssessmentPlan.value.patientIssueAndComplain = value;
                              },
                              isRequired: false),
                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Text(
                          'Investigation',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                         //patientInvestigation

                          PatientText(
                              title: "Blood Investigation",
                              color: Colors.red,
                              hintText:
                              "Provide Blood Investigation here",
                              initialValue: _patientController.patientInvestigation.value.bloodInvestigation,
                              onChanged: (value){
                                initialValue: _patientController.patientInvestigation.value.bloodInvestigation = value;
                              },
                              isRequired: false),


                          PatientText(
                              title: "Urine Investigation",
                              color: Colors.amber[500],
                              hintText:
                              "Provide Urine Investigation here",
                              initialValue: _patientController.patientInvestigation.value.urineInvestigation,
                              onChanged: (value){
                                initialValue: _patientController.patientInvestigation.value.urineInvestigation = value;
                              },
                              isRequired: false),

                          PatientText(
                              title: "Bio Chemistry Investigation",
                              color: Colors.blue,
                              hintText:
                              "Provide Bio Chemistry Investigation here",
                              initialValue: _patientController.patientInvestigation.value.bioChemistryInvestigation,
                              onChanged: (value){
                                initialValue: _patientController.patientInvestigation.value.bioChemistryInvestigation = value;
                              },
                              isRequired: false),



                          PatientText(
                              title: "Other Investigation",
                              hintText:
                              "Provide Other Investigation here",
                              initialValue: _patientController.patientInvestigation.value.otherInvestigation,
                              onChanged: (value){
                                initialValue: _patientController.patientInvestigation.value.otherInvestigation = value;
                              },
                              isRequired: false),

                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Text(
                          'Imaging',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                          PatientImaging(),

                      Obx(() =>   GestureDetector(
                        onTap: (){
                          if(_patientController.patientImagingList.length>0){

                            showMaterialModalBottomSheet(
                                expand: true,
                                backgroundColor: Colors.transparent,
                                isDismissible: false,
                                context: context, builder: (context){
                              return Material(
                                child: Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.amber,
                                    automaticallyImplyLeading: false,
                                    title: Text('Imaging Files'),
                                    actions: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.close))
                                    ],
                                  ),
                                  body: PatientImagingList()

                                ),
                              );
                            });
                          }
                        },
                        child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text('${_patientController.patientImagingList.length} file added' )),
                      )),

                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: Color(0xFF5A227E),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Text(
                          'Prescription',
                          style: TextStyle(
                            color: Color(0xFF5A227E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        children: [
                          Obx(() => DataTable(
                            columnSpacing: 25.0,
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color(0xFF5A227E)),
                                headingTextStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Name',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Type",
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Frequency",
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataColumn(
                                      label: Text(
                                        "DEL",
                                        style: TextStyle(fontSize: 10),
                                      )),
                                ],
                                rows: createRowPres(),
                              )),
                          Container(
                            //alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF5A227E),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  _showBottomOptionPres(context, _nameController,
                                      _descController, _dateController);

                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                        trailing: Icon(
                          _customTileExpanded
                              ? Icons.arrow_drop_down_circle
                              : Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        top: MediaQuery.of(context).size.height * 0.1,
        left: 0,
        right: 0,
        bottom: 0,
      ),
    ]);
  }

  List<DataRow> createRow() {
    List<OperationPerformedModal> diagnosisList =
        _patientController.patient.value.diagnosisList!;

    return diagnosisList.map<DataRow>((e) {
      return DataRow(cells: [
        DataCell(
          Text(
            e.diagnosis!,
            style: TextStyle(fontSize: 10),
          ),
        ),
        DataCell(Text(
          e.operationPerformed.toString(),
          style: TextStyle(fontSize: 10),
        )),
        DataCell(Text(
          e.operationPerformedDate!,
          style: TextStyle(fontSize: 10),
        )),
        DataCell(
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                diagnosisList.remove(e);
                _patientController.updatePatientDiagnosisList(diagnosisList);
              });
            },
          ),
        ),
      ]);
    }).toList();
  }

  List<DataRow> createRowPres() {
    List prescriptionList =
        _patientController.patientPrescriptionModalList.value!;
    return prescriptionList.map<DataRow>((e) {

      /*"Ear Drop","Eye Drop","Nasal Drop","Ointment","Syringe","Syrup","Tablet"*/
      String imageType="";
      switch(e.type){
        case "Ear Drop":
          imageType = "assets/images/presc/eardrop.png";
          break;

        case "Eye Drop":
          imageType = "assets/images/presc/eyedrop.png";
          break;


        case "Nasal Drop":
          imageType = "assets/images/presc/nasaldrops.png";
          break;

        case "Ointment":
          imageType = "assets/images/presc/ointment.png";
          break;


        case "Syringe":
          imageType = "assets/images/presc/syringe.png";
          break;

        case "Syrup":
          imageType = "assets/images/presc/syrup.png";
          break;

        case "Tablet":
          imageType = "assets/images/presc/tablet.png";
          break;

        default:
          imageType = "assets/images/presc/eardrop.png";
      }


      return DataRow(cells: [
        DataCell(
          Text(
            e.name!,
            style: TextStyle(fontSize: 10),
          ),
        ),
        DataCell(Image(
          height: 20,
          width: 20,
          image: AssetImage(imageType),)),
        DataCell(Text(
          e.frequency,
          style: TextStyle(fontSize: 10),
        )),

        DataCell(
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
              size: 15,
            ),
            onPressed: () {
              setState(() {
                prescriptionList.remove(e);
                _patientController.updatePrescriptionList(prescriptionList);
              });
            },
          ),
        ),
      ]);
    }).toList();
  }



  _showBottomOption(BuildContext context, TextEditingController name,
      TextEditingController desc, TextEditingController dateTime) async {
    ScrollController _scrollController = ScrollController();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    dateTime.text = formattedDate;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Diagnosis Name',
                          ),
                          onChanged: (value) {
                            name.text = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Operation Performed',
                          ),
                          onChanged: (value) {
                            desc.text = value;
                          },
                        ),
                        TextFormField(
                          initialValue: formattedDate,
                          decoration: InputDecoration(
                            labelText: 'Operation Performed Date',
                          ),
                          onChanged: (value) {
                            dateTime.text = value;
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF5A227E)),
                          onPressed: () {
                            _patientController.addPatientDiagnosisList(
                                OperationPerformedModal(
                                    diagnosis: name.text,
                                    operationPerformed: desc.text,
                                    operationPerformedDate: dateTime.text));

                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Text('Add'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom == 0
                              ? 10
                              : 3000,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }








  _showBottomOptionPres(BuildContext context, TextEditingController name,
      TextEditingController freq, TextEditingController type) async {
    ScrollController _scrollController = ScrollController();

    List<String>  presType=["Ear Drop","Eye Drop","Nasal Drop","Ointment","Syringe","Syrup","Tablet"];

    String? selected="Tablet";

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'chemical Name',
                          ),
                          onChanged: (value) {
                            name.text = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Frequency',
                          ),
                          onChanged: (value) {
                            freq.text = value;
                          },
                        ),
                        // TextFormField(
                        //   initialValue: 'formattedDate',
                        //   decoration: InputDecoration(
                        //     labelText: 'Operation Performed Date',
                        //   ),
                        //   onChanged: (value) {
                        //     type.text = value;
                        //   },
                        // ),

                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),

                            child: const Text('Select Prescription Type', style: TextStyle(fontSize: 22.0),)),
                        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return  DropdownButton(
                  value: selected,
                  items:presType.map((String item) {
                    return DropdownMenuItem(child: Text(item), value: item,);
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print(value.toString());
                      selected = value.toString();

                    });
                  });
            }

                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF5A227E)),
                          onPressed: () {
                            PrescriptionModal _prescriptionModal = PrescriptionModal();
                            _prescriptionModal.name = name.text;
                            _prescriptionModal.frequency = freq.text;
                            _prescriptionModal.type=selected.toString();

                            Navigator.pop(context);
                            if(_prescriptionModal.name!=""&& _prescriptionModal.frequency!=""&&_prescriptionModal.type!=""){
                              _patientController.patientPrescriptionModalList.add(_prescriptionModal);

                            }

                            else {

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(milliseconds: 400),
                                content: const Text('Field Missing!'),
                                backgroundColor: Colors.red.shade300,
                              ));
                            }


                          },
                          child: Text('Add'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom == 0
                              ? 10
                              : 3000,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }







}

class PanelTitle extends StatelessWidget {
  final String tileValue;
  final bool isRequired;
  final String hint;
  final Function(String) onChange;
  final String initialValue;

  PanelTitle(
      {Key? key,
      required this.tileValue,
      required this.isRequired,
      required this.onChange,
      this.initialValue = "",
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: <TextSpan>[
              TextSpan(
                text: tileValue,
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5A227E),
                    fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: isRequired ? " *" : "",
                style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
              ),
            ]),
          ),
          TextFormField(
            initialValue: initialValue == "" ? null : initialValue,
            onChanged: onChange,
            // style:TextStyle( color: Color(0xFF5A227E)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14, color: Color(0xFF5A227E)),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderRadioGroup extends StatelessWidget {
  final PatientController _patientController = Get.put(PatientController());
  late String genderText;
  late Gender selectedGender;
  @override
  Widget build(BuildContext context) {
    genderText = _patientController.patient.value.sex!;

    if (genderText == "Male" || genderText == "") {
      selectedGender = Gender.Male;
    } else if (genderText == "Female") {
      selectedGender = Gender.Female;
    } else {
      selectedGender = Gender.Others;
    }

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: GenderPickerWithImage(
        showOtherGender: true,
        verticalAlignedText: false,
        selectedGender: selectedGender,
        selectedGenderTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          selectedGender = gender!;
          if (gender == Gender.Male) {
            genderText = "Male";
            _patientController.patient.value.sex = "Male";
          } else if (gender == Gender.Female) {
            genderText = "Female";
            _patientController.patient.value.sex = "Female";
          } else {
            genderText = "Other";
            _patientController.patient.value.sex = "Other";
          }
        },
        equallyAligned: true,
        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 50, //default : 40
      ),
    );
  }
}



class PatientText extends StatelessWidget {
  PatientText(
      {Key? key,
       this.title="",
      required this.hintText,
      required this.isRequired,
        this.initialValue="",
        this.color,
      this.onChanged
      })
      : super(key: key);
  final String title;
  final String hintText;
  final bool isRequired;
  final String initialValue;
  final Function(String)? onChanged;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title==""?SizedBox(height:0):
      Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14,
                color:color!=null?color:Color(0xFF5A227E),
                fontWeight: FontWeight.w500),
          ),


          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
          ),
        ]),
      ),
      Padding(
        padding: EdgeInsets.only(top: title==""?0:10, bottom: 10),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          onChanged: onChanged,
          initialValue: initialValue,
          decoration: InputDecoration(

            border: OutlineInputBorder(),
            hintMaxLines: 10,
            hintText: hintText,


            hintStyle: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      )
    ]);
  }
}




import 'package:dio/dio.dart';
import 'package:doc_talk/controller/dashboard_data_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controller/patient_controller.dart';
import '../../../networks/api_constants.dart';
import 'package:dio/src/form_data.dart' as FormDatas;
import 'package:dio/src/multipart_file.dart' as FilePart;

final PatientController _patientController = Get.put(PatientController());
final DashboardDataController _dashboardController =
    Get.put(DashboardDataController());
enum synopsisType {
  CREATE_PATIENT,
  PILCCOD,
  VITALS,
  HEIGHT_WEIGHT_BMI,
  GCS,
  SYSTEMATICLOCALEXAM,
  OTHEREXAM,
  ASSESMENT,
  PLAN,
  ISSUENCOMPLAIN,
  BLOOD_INVESTIGATION,
  URINE_INVESTIGATION,
  BIO_CHEMISTRY,
  OTHER_INVESTIGATION,
  IMAGING,
  PRESCRIPTION,
  ARCHIVED,
}

Dio getApiClient() {
  Dio _dio = Dio();
  _dio.options = BaseOptions(connectTimeout: 50000, receiveTimeout: 50000);
  _dio.interceptors.clear();
  _dio.options.baseUrl = BASE_URL;
  return _dio;
}

Future<dynamic> addNewPatient(String chatGroupID) async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl = CREATE_PATIENT;
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  dynamic diagnosisListArray = [];

  for (int i = 0;
      i < _patientController.patient.value.diagnosisList!.length;
      i++) {
    diagnosisListArray
        .add(_patientController.patient.value.diagnosisList![i].toMap());
  }

  var map = {
    'isArchived': false,
    'created_by': _dashboardController.dashboardDataModal.value.fullName,
    'associated_room': chatGroupID,
    "bedNo": _patientController.patient.value.bedNo,
    "wardName": _patientController.patient.value.wardNo,
    "ipNumber": _patientController.patient.value.ipNumber,
    "firstName": _patientController.patient.value.firstName,
    "middleName": _patientController.patient.value.middleName,
    "lastName": _patientController.patient.value.lastName,
    "occupation": _patientController.patient.value.occupation,
    "age": _patientController.patient.value.age,
    "gender": _patientController.patient.value.sex,
    "contactNumber": _patientController.patient.value.contactNumber,
    "temporaryAddress": _patientController.patient.value.address,
    "permanentAddress": _patientController.patient.value.address,
    "admittedDate": _patientController.patient.value.admittedDate,
    "admittedDepartment": _patientController.patient.value.department,
    "admittedUnit": _patientController.patient.value.unit,
    "presentingComplain": _patientController.patient.value.presentingComplains,
    "knownMedicalHistory": _patientController.patient.value.knownMedicalHistory,
    "menstrualHistory": _patientController.patient.value.menstrualHistory,
    "obstetricHistory": _patientController.patient.value.obstetricHistory,
    "operationPerformedModels": diagnosisListArray,
    "otherRelevantHistory":
        _patientController.patient.value.otherRelevantHistory,
    "hopi": _patientController.patient.value.hopi,
    "pastHistory": _patientController.patient.value.pastHistory,
    "familyHistory": _patientController.patient.value.familyHistory,
    "socioEconomicHistory":
        _patientController.patient.value.socioEconomicsHistory
  };

  var response = await _dio.post(CREATE_PATIENT,
      data: map,
      options: Options(
          method: 'POST',
          responseType: ResponseType.json // or ResponseType.JSON
          ));
 var result = response.data;
print(response.data);

  if(result.containsKey("data")){
    _patientController.patient.value.id = result["data"]["_id"];
    addSynopsis(synopsisType.CREATE_PATIENT);

    await updateGeneralExamination();
    await updateAssessmentPlanAndIssue();
    await updateInvestigation();
    await updateImaging();
    await updatePrescription();
  }

  else{
    _patientController.patient.value.id="";
  }






}

Future<dynamic> changeArchiveStatusPatient(bool status) async {
  Map myMap = {
    "isArchived": status,
    "last_update_by": _dashboardController.dashboardDataModal.value.fullName
  };

  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_PATIENT_BASIC_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var response = await _dio.put(
      '$UPDATE_PATIENT_BASIC_INFO${_patientController.patient.value.id}',
      data: myMap,
      options: Options(
          method: 'PUT', responseType: ResponseType.json // or ResponseType.JSON
          ));

  print(response.data['data']);

  addSynopsis(synopsisType.ARCHIVED);




}

Future<dynamic> updatePatientProfile() async {
  dynamic diagnosisListArray = [];

  for (int i = 0;
      i < _patientController.patient.value.diagnosisList!.length;
      i++) {
    diagnosisListArray
        .add(_patientController.patient.value.diagnosisList![i].toMap());
  }

  var map = {
    'isArchived': false,
    'created_by': _dashboardController.dashboardDataModal.value.fullName,
    "bedNo": _patientController.patient.value.bedNo,
    "wardName": _patientController.patient.value.wardNo,
    "ipNumber": _patientController.patient.value.ipNumber,
    "firstName": _patientController.patient.value.firstName,
    "middleName": _patientController.patient.value.middleName,
    "lastName": _patientController.patient.value.lastName,
    "occupation": _patientController.patient.value.occupation,
    "age": _patientController.patient.value.age,
    "gender": _patientController.patient.value.sex,
    "contactNumber": _patientController.patient.value.contactNumber,
    "temporaryAddress": _patientController.patient.value.address,
    "permanentAddress": _patientController.patient.value.address,
    "admittedDate": _patientController.patient.value.admittedDate,
    "admittedDepartment": _patientController.patient.value.department,
    "admittedUnit": _patientController.patient.value.unit,
    "presentingComplain": _patientController.patient.value.presentingComplains,
    "knownMedicalHistory": _patientController.patient.value.knownMedicalHistory,
    "menstrualHistory": _patientController.patient.value.menstrualHistory,
    "obstetricHistory": _patientController.patient.value.obstetricHistory,
    "operationPerformedModels": diagnosisListArray,
    "otherRelevantHistory":
        _patientController.patient.value.otherRelevantHistory,
    "hopi": _patientController.patient.value.hopi,
    "pastHistory": _patientController.patient.value.pastHistory,
    "familyHistory": _patientController.patient.value.familyHistory,
    "socioEconomicHistory":
        _patientController.patient.value.socioEconomicsHistory
  };

  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_PATIENT_BASIC_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var response = await _dio.put(
      '$UPDATE_PATIENT_BASIC_INFO${_patientController.patient.value.id}',
      data: map,
      options: Options(
          method: 'PUT', responseType: ResponseType.json // or ResponseType.JSON
          ));

  print(response.data);

  await updateGeneralExamination();
  await updateAssessmentPlanAndIssue();
  await updateInvestigation();
  await updateImaging();
  await updatePrescription();


  // addSynopsis();
}

Future<dynamic> updateGeneralExamination() async {
  await updatePatientPilccod();
  await updateVitals();
  await updateHeightWeightBMI();
  await updateGCS();
  await updateSystematicLocalExam();
  await updateOtherDiseaseExam();
}

Future<dynamic> updateAssessmentPlanAndIssue() async {
  await updateAssessment();
  await updatePlan();
  await updateIssueAndComplain();
}

Future<dynamic> updateInvestigation() async {
  await updateHematology();
  await updateUrine();
  await updateBioChemistry();
  await updateOtherInvestigation();
}

addSynopsis(
  synopsisType type,
) async {
//TODO

  switch (type) {

    // CREATE_PATIENT, PILCCOD, VITALS, HEIGHT_WEIGHT_BMI, GCS, SYSTEMATICLOCALEXAM,OTHEREXAM,
// ASSESMENT,PLAN,ISSUENCOMPLAIN, BLOOD_INVESTIGATION,
// URINE_INVESTIGATION,BIO_CHEMISTRY, OTHER_INVESTIGATION, IMAGING, PRESCRIPTION, ARCHIVED,

    case synopsisType.CREATE_PATIENT:
      Map dataMap = {
        "type": 'CREATE_PATIENT',
        "data": _patientController.patient.value.toMap()
      };

      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.PILCCOD:
      Map dataMap = {
        "type": 'PILCCOD',
        "data": _patientController.generalExamination.value.toMap()
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.VITALS:
      Map dataMap = {
        "type": 'VITALS',
        "data": _patientController.vitals.value.toMap()
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.HEIGHT_WEIGHT_BMI:
      Map dataMap = {
        "type": 'HEIGHT_WEIGHT_BMI',
        "data": _patientController.heightWeightBmi.value.toMap()
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.GCS:
      Map dataMap = {
        "type": 'GCS',
        "data": _patientController.glasgowComaScale.value.toMap()
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.SYSTEMATICLOCALEXAM:
      Map dataMap = {
        "type": 'SYSTEMATICLOCALEXAM',
        "data": _patientController
            .systemAndOtherExam.value.systematiclocalExaminationValue
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.OTHEREXAM:
      Map dataMap = {
        "type": 'OTHEREXAM',
        "data": _patientController.systemAndOtherExam.value.otherExamValue
      };
      _patientController.addArraySynopsis(dataMap);

      break;

    case synopsisType.ASSESMENT:
      Map dataMap = {
        "type": 'ASSESMENT',
        "data": _patientController.patientAssessmentPlan.value.patientAssessment
      };
      _patientController.addArraySynopsis(dataMap);
      break;


    case synopsisType.PLAN:
      Map dataMap = {
        "type": 'PLAN',
        "data": _patientController.patientAssessmentPlan.value.patientPlan
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.ISSUENCOMPLAIN:
      Map dataMap = {
        "type": 'ISSUENCOMPLAIN',
        "data": _patientController.patientAssessmentPlan.value.patientIssueAndComplain
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.BLOOD_INVESTIGATION:
      Map dataMap = {
        "type": 'BLOOD_INVESTIGATION',
        "data": _patientController.patientInvestigation.value.bloodInvestigation
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.URINE_INVESTIGATION:
      Map dataMap = {
        "type": 'URINE_INVESTIGATION',
        "data": _patientController.patientInvestigation.value.urineInvestigation
      };
      _patientController.addArraySynopsis(dataMap);
      break;


    case synopsisType.BIO_CHEMISTRY:
      Map dataMap = {
        "type": 'BIO_CHEMISTRY',
        "data": _patientController.patientInvestigation.value.bioChemistryInvestigation
      };
      _patientController.addArraySynopsis(dataMap);
      break;


    case synopsisType.OTHER_INVESTIGATION:
      Map dataMap = {
        "type": 'OTHER_INVESTIGATION',
        "data": _patientController.patientInvestigation.value.otherInvestigation
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.IMAGING:
      Map dataMap = {
        "type": 'IMAGING',
        "data": _patientController.patientImagingList
      };
      _patientController.addArraySynopsis(dataMap);
      break;

    case synopsisType.PRESCRIPTION:
      dynamic prescriptionList =[];
      for (int i = 0;
      i < _patientController.patientPrescriptionModalList.length;
      i++) {
        prescriptionList
            .add(_patientController.patientPrescriptionModalList[i].toMap());
      }

      Map dataMap = {
        "type": 'PRESCRIPTION',
        "data": prescriptionList
      };
      _patientController.addArraySynopsis(dataMap);
      break;



    default:
      null;
  }
}

Future<dynamic> updatePatientPilccod() async {
  if (_patientController.flagPICCDDUpdate.value == true) {
    var currentDate = DateTime.now().millisecondsSinceEpoch;
    Map generaExaminationDiseaseMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "generalExamination": _patientController.generalExamination.value.toMap(),
    };

    Map sendMap = {
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName,
      "generalExamination": generaExaminationDiseaseMap,
    };

    Dio _dio = getApiClient();
    _dio.options.baseUrl =
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;
    _dio.options.headers["x-access-token"] =
        _dashboardController.dashboardDataModal.value.accessToken;

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(
      synopsisType.PILCCOD,
    );
  }
}

Future<dynamic> updateVitals() async {
  if (_patientController.flagVitalsUpdate.value == true) {
    Dio _dio = getApiClient();
    _dio.options.baseUrl =
        '$UPDATE_PATIENT_VITALS${_patientController.patient.value.id}';
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;
    _dio.options.headers["x-access-token"] =
        _dashboardController.dashboardDataModal.value.accessToken;

    var date = DateTime.now().millisecondsSinceEpoch;

    var vitalsMap = {
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "date": date,
      "data": _patientController.vitals.value.toMap(),
    };

    Map data = {
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName,
      "vitals": vitalsMap,
    };

    var response = await _dio.put(
        '$UPDATE_PATIENT_VITALS${_patientController.patient.value.id}',
        data: data,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response);
    addSynopsis(synopsisType.VITALS);
  }
}

Future<dynamic> updateHeightWeightBMI() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;
  if (_patientController.flagHeightWeightBmiUpdate.value == true) {
    var currentDate = DateTime.now().millisecondsSinceEpoch;

    Map heightWeightBmiMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController.heightWeightBmi.value.toMap(),
    };

    Map sendMap = {
      "heightWeightBmi": heightWeightBmiMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.HEIGHT_WEIGHT_BMI);
  }
}

Future<dynamic> updateGCS() async {
  if (_patientController.flagGCSUpdate.value == true) {
    Dio _dio = getApiClient();
    _dio.options.baseUrl =
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
    _dio.options.connectTimeout = 500000; //5s
    _dio.options.receiveTimeout = 500000;
    _dio.options.headers["x-access-token"] =
        _dashboardController.dashboardDataModal.value.accessToken;

    var currentDate = DateTime.now().millisecondsSinceEpoch;
    Map gcsMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController.glasgowComaScale.value.toMap(),
    };

    Map sendMap = {
      "mentalStatus": gcsMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.GCS);
  }
}

Future<dynamic> updateSystematicLocalExam() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController
          .systemAndOtherExam.value.systematiclocalExaminationValue !=
      "") {
    Map systematicLocalExamMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController
          .systemAndOtherExam.value.systematiclocalExaminationValue,
    };

    Map sendMap = {
      "systematicLocalExamValue": systematicLocalExamMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.SYSTEMATICLOCALEXAM);
  }
}

Future<dynamic> updateOtherDiseaseExam() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController.systemAndOtherExam.value.otherExamValue != "") {
    Map otherDiseaseExamMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController.systemAndOtherExam.value.otherExamValue,
    };

    Map sendMap = {
      "systematicLocalExamValue": otherDiseaseExamMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.OTHEREXAM);
  }
}

Future<dynamic> updateAssessment() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController.patientAssessmentPlan.value.patientAssessment != "") {
    Map assessmentMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController.patientAssessmentPlan.value.patientAssessment,
    };

    Map sendMap = {
      "assessment": assessmentMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    print(sendMap);

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.ASSESMENT);
  }
}

Future<dynamic> updatePlan() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController.patientAssessmentPlan.value.patientPlan != "") {
    Map patientPlanMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController.patientAssessmentPlan.value.patientPlan,
    };

    Map sendMap = {
      "patientPlan": patientPlanMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    print(sendMap);

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.PLAN);
  }
}

Future<dynamic> updateIssueAndComplain() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController.patientAssessmentPlan.value.patientIssueAndComplain !=
      "") {
    Map patientIssueAndComplain = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController
          .patientAssessmentPlan.value.patientIssueAndComplain,
    };

    Map sendMap = {
      "patientIssueAndComplain": patientIssueAndComplain,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    print(sendMap);

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.ISSUENCOMPLAIN);
  }
}

Future<dynamic> updateHematology() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController.patientInvestigation.value.bloodInvestigation != "") {
    Map hematologyMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController.patientInvestigation.value.bloodInvestigation,
    };

    Map sendMap = {
      "hematology": hematologyMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.BLOOD_INVESTIGATION);
  }
}

Future<dynamic> updateUrine() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController.patientInvestigation.value.urineInvestigation != "") {
    Map urineMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController.patientInvestigation.value.urineInvestigation,
    };

    Map sendMap = {
      "urine": urineMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.URINE_INVESTIGATION);
  }
}

Future<dynamic> updateBioChemistry() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  var currentDate = DateTime.now().millisecondsSinceEpoch;
  if (_patientController.patientInvestigation.value.bioChemistryInvestigation !=
      "") {
    Map bioChemistryMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": _patientController
          .patientInvestigation.value.bioChemistryInvestigation,
    };

    Map sendMap = {
      "bioChemistry": bioChemistryMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    print(sendMap);

    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.BIO_CHEMISTRY);
  }
}

Future<dynamic> updateOtherInvestigation() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$ADD_PATIENT_OTHER_INVESTIGATION${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  if (_patientController.patientInvestigation.value.otherInvestigation != "") {
    FormDatas.FormData formData = new FormDatas.FormData.fromMap({
      "title": 'Other Ivestigation',
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName,
      "remark":
          _patientController.patientInvestigation.value.otherInvestigation,
      "addedBy": _dashboardController.dashboardDataModal.value.fullName,
      "img": null,
    });

    var response = await _dio.put(
        '$ADD_PATIENT_OTHER_INVESTIGATION${_patientController.patient.value.id}',
        data: formData,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);
    addSynopsis(synopsisType.OTHER_INVESTIGATION);
  }
}

Future<dynamic> updateImaging() async {
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$ADD_PATIENT_OTHER_INVESTIGATION${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  if(_patientController.patientImagingList.length>0){
    for (int i = 0; i < _patientController.patientImagingList.length; i++) {

      FormDatas.FormData formData = new FormDatas.FormData.fromMap({
        "title": _patientController.patientImagingList[i].title,
        "last_updated_by": _dashboardController.dashboardDataModal.value.fullName,
        "remark": _patientController.patientImagingList[i].remark,
        "addedBy": _dashboardController.dashboardDataModal.value.fullName,
        "img": await FilePart.MultipartFile.fromFile(
            _patientController.patientImagingList[i].image.path,
            filename:
            _patientController.patientImagingList[i].image.path.toString()),
      });

      var response = await _dio.put(
          '$ADD_PATIENT_OTHER_INVESTIGATION${_patientController.patient.value.id}',
          data: formData,
          options: Options(
              method: 'PUT',
              responseType: ResponseType.json // or ResponseType.JSON
          ));

      print(response.data);
      addSynopsis(synopsisType.IMAGING);
    }
  }

}

Future<dynamic> updatePrescription() async {
  /**/
  Dio _dio = getApiClient();
  _dio.options.baseUrl =
      '$ADD_PATIENT_OTHER_INVESTIGATION${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;

  if (_patientController.patientPrescriptionModalList.length > 0) {
    dynamic prescriptionList = [];
    for (int i = 0;
        i < _patientController.patientPrescriptionModalList.length;
        i++) {
      prescriptionList
          .add(_patientController.patientPrescriptionModalList[i].toMap());
    }

    var currentDate = DateTime.now().millisecondsSinceEpoch;
    Map prescriptionListMap = {
      "date": currentDate,
      "added_by": _dashboardController.dashboardDataModal.value.fullName,
      "user_img": _dashboardController.dashboardDataModal.value.image,
      "data": prescriptionList,
    };

    Map sendMap = {
      "prescription": prescriptionListMap,
      "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
    };

    print(sendMap);
    var response = await _dio.put(
        '$UPDATE_SPECIFIC_EXAMINATION_INFO${_patientController.patient.value.id}',
        data: sendMap,
        options: Options(
            method: 'PUT',
            responseType: ResponseType.json // or ResponseType.JSON
            ));

    print(response.data);

    addSynopsis(synopsisType.PRESCRIPTION);
  }

  }



Future<dynamic> updateSynopsis() async {

  Dio _dio = getApiClient();
  _dio.options.baseUrl =
  '$UPDATE_SYNOPSIS_PATIENT${_patientController.patient.value.id}';
  _dio.options.connectTimeout = 500000; //5s
  _dio.options.receiveTimeout = 500000;
  _dio.options.headers["x-access-token"] =
      _dashboardController.dashboardDataModal.value.accessToken;
  var currentDate = DateTime.now().millisecondsSinceEpoch;

  Map synopsisMap = {
    "date": currentDate,
    "added_by": _dashboardController.dashboardDataModal.value.fullName,
    "user_img": _dashboardController.dashboardDataModal.value.image,
    "data": _patientController.patientSynopsis.value,
  };

  Map sendMap = {
    "synopsis": synopsisMap,
    "last_updated_by": _dashboardController.dashboardDataModal.value.fullName
  };

  print('$UPDATE_SYNOPSIS_PATIENT${_patientController.patient.value.id}');
  print(sendMap);

  var response = await _dio.put(
      '$UPDATE_SYNOPSIS_PATIENT${_patientController.patient.value.id}',
      data: sendMap,
      options: Options(
          method: 'PUT',
          responseType: ResponseType.json // or ResponseType.JSON
      ));

  print(response.data);
  addSynopsis(synopsisType.IMAGING);
}





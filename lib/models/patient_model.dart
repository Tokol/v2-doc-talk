import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Patient {
//General Information
  String? id;
  String? firstName, middleName, lastName;
  String? age;
  String? sex;
  String? contactNumber;
  String? address;
  String? occupation;
  String? admittedDate;
  String? bedNo;
  String? wardNo;
  String? ipNumber;
  String? department;
  String? unit;

  //diagnosis
  List<OperationPerformedModal>? diagnosisList;

  //complains

  String? presentingComplains;

//patiemt history
  String? knownMedicalHistory;
  String? menstrualHistory;
  String? obstetricHistory;
  String? otherRelevantHistory;
  String? hopi;
  String? pastHistory;
  String? familyHistory;
  String? socioEconomicsHistory;
  String? lastUpdateBy;
  String? lastUpdateAt;

  void resetPatientData() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    id = "";
    firstName = "";
    middleName = "";
    lastName = "";
    age = "";
    sex = "";
    contactNumber = "";
    address = "";
    occupation = "";
    admittedDate = formatted;
    bedNo = "";
    wardNo = "";
    ipNumber = (DateTime.now().millisecondsSinceEpoch).toString();
    department = "";
    unit = "";
    diagnosisList = [];

    presentingComplains = "";

    knownMedicalHistory = "";
    menstrualHistory = "";
    obstetricHistory = "";
    otherRelevantHistory = "";
    hopi = "";
    pastHistory = "";
    familyHistory = "";
    socioEconomicsHistory = "";

     lastUpdateBy="";
     lastUpdateAt="";
  }

  Map<bool, String> isValid() {
    Map<bool, String> validate;

    if (firstName == "") {
      validate = {false: "First name missing!"};
    } else if (age == "") {
      validate = {false: "age is missing!"};
    } else if (admittedDate == "") {
      validate = {false: "last name is missing!"};

    } else if (bedNo == "") {
      validate = {false: "Bed Number is missing!"};
    } else {
      validate = {true: "validated!"};
    }

    return validate;
  }


  Map<String, String> toMap(){

    var diagnosisArray=[];
    for(int i=0;i<diagnosisList!.length;i++){
      diagnosisArray.add(diagnosisList![i].toMap());
    }

    Map<String, String> patients ={
    "id":id!,
    "firstName" : firstName!,
    "middleName" : middleName!,
    "lastName" : lastName!,
    "age" : age!,
    "sex" : sex!,
    "contactNumber" : contactNumber!,
    "address" : address!,
    "occupation" : occupation!,
    "admittedDate" : admittedDate!,
    "bedNo" : bedNo!,
    "wardNo" : wardNo!,
    "ipNumber" : ipNumber!,
    "department" : department!,
    "unit" :unit!,
    "diagnosisList" : diagnosisArray.toString(),
    "presentingComplains" :presentingComplains!,
    "knownMedicalHistory" : knownMedicalHistory!,
    "menstrualHistory" :menstrualHistory!,
    "obstetricHistory" : obstetricHistory!,
    "otherRelevantHistory" :otherRelevantHistory!,
    "hopi" :hopi!,
    "pastHistory" : pastHistory!,
    "familyHistory": familyHistory!,

    };

    return patients;
  }



}

class OperationPerformedModal {
  String? diagnosis;
  String? operationPerformed;
  String? operationPerformedDate;
  OperationPerformedModal(
      {this.diagnosis, this.operationPerformed, this.operationPerformedDate});

  Map <String,String> toMap() {
    Map <String,String> map = {
      "diagnosis": diagnosis!,
      "operationPerformed": operationPerformed!,
      "operationPerformedDate": operationPerformedDate!
    };

    return map;
  }
}

class GeneraExaminationModal {
  String pallorSelected = "null";
  String pallorRemark = "";

  String icterusSelected = "null";
  String icterusRemark = "";

  String lymphedenopathySelected = "null";
  String lymphedenopathyRemark = "";

  String cyanosisSelected = "null";
  String cyanosisRemark = "";

  String clubbingSelected = "null";
  String clubbingRemark = "";

  String oedemaSelected = "null";
  String oedemaRemark = "";

  String dehydration_hydrationSelected = "null";
  String dehydration_hydrationRemark = "";

  reset() {
    pallorSelected = "null";
    pallorRemark = "";

    icterusSelected = "null";
    icterusRemark = "";

    lymphedenopathySelected = "null";
    lymphedenopathyRemark = "";

    cyanosisSelected = "null";
    cyanosisRemark = "";

    clubbingSelected = "null";
    clubbingRemark = "";

    oedemaSelected = "null";
    oedemaRemark = "";

    dehydration_hydrationSelected = "null";
    dehydration_hydrationRemark = "";
  }

  Map<String, String> toMap() {
    Map<String, String> map = {
      "pallor": pallorSelected,
      "pallorRemark": pallorRemark,
      "Icterus": icterusSelected,
      "IcterusRemark": icterusRemark,
      "Lymphedenopathy": lymphedenopathySelected,
      "LymphedenopathyRemark": lymphedenopathyRemark,
      "Cyanosis": cyanosisSelected,
      "CyanosisRemark": cyanosisRemark,
      "Clubbing": clubbingSelected,
      "ClubbingRemark": clubbingRemark,
      "Oedema": oedemaSelected,
      "OedemaRemark": oedemaRemark,
      "Dehydration_hydration": dehydration_hydrationSelected,
      "Dehydration_hydrationRemark": dehydration_hydrationRemark
    };

    return map;
  }

  /**P:pallor, I:Icterus, L:Lymphedenopathy,C:Cyanosis, C:Clubbing,O:Oedema,D:Dehydration/hydration status **/

}

class Vitals {
  String bloodPressureValue = "";
  String bloodPressureRemark = "";
  String pulseValue = "";
  String pulseRemark = "";
  String respiratoryRateValue = "";
  String respiratoryRateRemark = "";
  String bodyTemperatureValue = "";
  String bodyTemperatureRemark = "";
  String spo2Value = "";
  String spo2Remark = "";
  String urineOutputValue = "";
  String urineOutPutRemark = "";
  String totalIntakeValue = "";
  String totalIntakeRemark = "";
  String painScaleValue = "";
  String painScaleRemark = "";
  String otherVitalValue = "";
  String otherVitalRemark = "";

  reset() {
    bloodPressureValue = "";
    bloodPressureRemark = "";
    pulseValue = "";
    pulseRemark = "";
    respiratoryRateValue = "";
    respiratoryRateRemark = "";
    bodyTemperatureValue = "";
    bodyTemperatureRemark = "";
    spo2Value = "";
    spo2Remark = "";
    urineOutputValue = "";
    urineOutPutRemark = "";
    totalIntakeValue = "";
    totalIntakeRemark = "";
    painScaleValue = "";
    painScaleRemark = "";
    otherVitalValue = "";
    otherVitalRemark = "";
  }

  Map<String,String> toMap(){
    Map<String, String> map ={
      "bloodPressure":bloodPressureValue,
      "bloodPressureRemark":bloodPressureRemark,
      "pulse":pulseValue,
      "pulseRemark":pulseRemark,
      "respiratoryRate":respiratoryRateValue,
      "respiratoryRateRemark":respiratoryRateRemark,
      "bodyTemperature":bodyTemperatureValue,
      "bodyTemperatureRemark":bodyTemperatureRemark,
      "spo2":spo2Value,
      "spo2Remark":spo2Remark,
      "urineOutput":urineOutputValue,
      "urineOutputRemark":urineOutPutRemark,
      "totalIntake":totalIntakeValue,
      "totalIntakeRemark":totalIntakeRemark,
      "painScale":painScaleValue,
      "painScaleRemark":painScaleRemark,
      "otherVital":otherVitalValue,
      "otherVitalRemark":otherVitalRemark

    };

    return map;

  }


}

class HeightWeightBmi {
  String height = "";
  String weight = "";
  String bmi = "";

  reset() {
    height = "";
    weight = "";
    bmi = "";
  }

  Map<String,String> toMap(){
    Map<String,String> map ={
      "height":height,
      "weight":weight,
      "bmi":bmi
    };
    return map;
  }

}

class GlasgowComaScaleModal {
  String eyeOpeningResponseValue = "";
  String eyeOpeningResponseRemark = "";
  String verbalResponseValue = "";
  String verbalResponseRemark = "";
  String motorResponseValue = "";
  String motorResponseRemark = "";

  reset() {
    eyeOpeningResponseValue = "";
    eyeOpeningResponseRemark = "";
    verbalResponseValue = "";
    verbalResponseRemark = "";
    motorResponseValue = "";
    motorResponseRemark = "";
  }

  Map<String, String> toMap(){
    Map<String, String> map={
      "eyeOpeningResponse":eyeOpeningResponseValue,
      "eyeOpeningResponseRemark":eyeOpeningResponseRemark,
      "verbalResponse":verbalResponseValue,
      "verbalResponseRemark":verbalResponseRemark,
      "motorResponse":motorResponseValue,
      "motorResponseRemark":motorResponseRemark

    };
    return map;
  }

}

class SystematicLocalExamAndOtherExamModal {
  String systematiclocalExaminationValue = "";
  String otherExamValue = "";
  reset() {
    systematiclocalExaminationValue = "";
    otherExamValue = "";
  }
}

class PatientIssueComplainModal {
  String patientAssessment = "";
  String patientPlan = "";
  String patientIssueAndComplain = "";
  reset() {
    patientAssessment = "";
    patientPlan = "";
    patientIssueAndComplain = "";
  }
}

class PatientInvestigationModal {
  String bloodInvestigation = "";
  String urineInvestigation = "";
  String bioChemistryInvestigation = "";
  String otherInvestigation = "";

  reset() {
    bloodInvestigation = "";
    urineInvestigation = "";
    bioChemistryInvestigation = "";
    otherInvestigation = "";
  }
}

class PatientImagingModal {
  String title = "";
  String remark = "";
  XFile? image;
}

class PrescriptionModal {
  String name = "";
  String type = "";
  String frequency = "";

  reset() {
    name = "";
    type = "";
    frequency = "";
  }

  Map<String,String> toMap(){
    Map<String, String> map={
      "name":name,
      "type":type,
      "frequency":frequency
    };
    return map;
  }

}

import 'package:get/get.dart';

import '../models/patient_model.dart';

class PatientController extends GetxController {
  final patient = Patient().obs;
  final generalExamination = GeneraExaminationModal().obs;
  final vitals = Vitals().obs;
  final heightWeightBmi = HeightWeightBmi().obs;
  final glasgowComaScale = GlasgowComaScaleModal().obs;
  final systemAndOtherExam = SystematicLocalExamAndOtherExamModal().obs;
  final patientAssessmentPlan = PatientIssueComplainModal().obs;
  final patientInvestigation = PatientInvestigationModal().obs;

  final patientImagingList = [].obs;

  final patientPrescriptionModalList = [].obs;

  final patientSynopsis = [].obs;

  var flagPICCDDUpdate = false.obs;
  var flagVitalsUpdate = false.obs;
  var flagHeightWeightBmiUpdate = false.obs;
  var flagGCSUpdate = false.obs;
  // var systematicLocalExamUpdate = false.obs;
  // var otherDiseaseExam = false.obs;

  void updateFlagPiccod(bool value) {
    flagPICCDDUpdate.value = value;
  }

  void updateFlagVitals(bool value) {
    flagVitalsUpdate.value = value;
  }

  void updateFlagWeightBmi(bool value) {
    flagHeightWeightBmiUpdate.value = value;
  }

  void updateFlagGCS(bool value) {
    flagGCSUpdate.value = value;
  }

  void updatePatientData(Patient updatePatient) {
    patient.update((newDashboardValue) {
      patient.value = updatePatient;
    });
  }

  void resetAllArray() {
    patientImagingList.value = [];
    patientPrescriptionModalList.value = [];
    patientImagingList.refresh();
    patientPrescriptionModalList.refresh();
    patientSynopsis.value=[];
    patientSynopsis.refresh();
  }


  void addArraySynopsis(dynamic item){
    patientSynopsis.add(item);
    patientSynopsis.refresh();
  }
  void addPatientDiagnosisList(
      OperationPerformedModal operationPerformedModal) {
    patient.update((newDashboardValue) {
      List<OperationPerformedModal> diagnosisList =
          patient.value.diagnosisList!;
      diagnosisList.add(operationPerformedModal);
      patient.value.diagnosisList = diagnosisList;
      patient.refresh();
    });
  }

  void updatePrescriptionList(List<dynamic> list) {
    patientPrescriptionModalList.value = list;
    patientPrescriptionModalList.refresh();
  }

  void updatePatientDiagnosisList(
      List<OperationPerformedModal> operationPerformedModal) {
    patient.update((newDashboardValue) {
      patient.value.diagnosisList = operationPerformedModal;
      patient.refresh();
    });
  }

  void addPatientImaging(dynamic patientImaging) {
    patientImagingList.add(patientImaging);
    patientImagingList.refresh();
  }


   reset(){
    Patient _patient = Patient();
    _patient.resetPatientData();
    updatePatientData(_patient);
    generalExamination.value.reset();
    vitals.value.reset();
    heightWeightBmi.value.reset();
    glasgowComaScale.value.reset();
    systemAndOtherExam.value.reset();
    patientAssessmentPlan.value.reset();
    patientInvestigation.value.reset();
    resetAllArray();
    updateFlagPiccod(false);
    updateFlagVitals(false);
    updateFlagWeightBmi(false);
    updateFlagGCS(false);
  }



}

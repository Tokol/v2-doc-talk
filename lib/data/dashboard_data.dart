import 'package:doc_talk/models/dasboard_data_model.dart';
import 'package:flutter/foundation.dart';

class DashBoardData  extends ChangeNotifier {
  DashboardDataModel dashboardDataModel;
  DashBoardData({required this.dashboardDataModel});

  void upDateDashboardData(DashboardDataModel dashboardDataModel){
    this.dashboardDataModel = dashboardDataModel;
    notifyListeners();
  }


}
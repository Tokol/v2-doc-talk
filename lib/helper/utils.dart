import 'package:flutter/material.dart';

class Utils {
  static final riKey1 = const Key('__RIKEY1__');
  static final riKey2 = const Key('__RIKEY2__');

  static final GlobalKey<NavigatorState> mainDashNav = GlobalKey();
  static final GlobalKey<NavigatorState> mainAppNav = GlobalKey();


  static String getShortCutOfString({required String longValue}){
    String shortCutName = "";
    List<String> groupSplittingArray = longValue.split(" ");
    for ( int i = 0; i<groupSplittingArray.length; i++){

      if( _isNumeric(groupSplittingArray[i])){
        shortCutName = shortCutName+" "+groupSplittingArray[i];
      }

      else {
        shortCutName =    shortCutName+" "+groupSplittingArray[i][0];
      }

    }

    return shortCutName;

  }



  static bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }


  static String dottedShortMessage({required String value, required int limit}) {
    if (value.length <= limit) {
      return value;
    }

    else  {
      String dottedValue = "";
      for (int i = 0; i < limit; i++) {
        dottedValue =  dottedValue+ " "+ value[i];
      }

      return dottedValue + "...";
    }

  }

}
import 'dart:io';

import 'package:flutter/material.dart';

class Utils {
  static final riKey1 = const Key('__RIKEY1__');
  static final riKey2 = const Key('__RIKEY2__');

  static final GlobalKey<NavigatorState> mainDashNav = GlobalKey();
  static final GlobalKey<NavigatorState> mainAppNav = GlobalKey();


  static String getShortCutOfString({required String longValue}){
   if(longValue==""||longValue==" "){
     return longValue;
   }

   String shortCutName = "";
   List<String> groupSplittingArray = longValue.split(" ");
   for ( int i = 0; i<groupSplittingArray.length; i++){

    try{
      if( _isNumeric(groupSplittingArray[i])){
        shortCutName = shortCutName+""+groupSplittingArray[i]+"";
      }

      else {
        shortCutName =    shortCutName+""+groupSplittingArray[i][0];
      }

    }

    catch(e){
      return (shortCutName).toUpperCase();
    }

   }

   return (shortCutName).toUpperCase();

  }

  static String getFirstWord({required String fullSentence}){
    String firstWord = "";
    List<String> groupSplittingArray = fullSentence.split(" ");
    firstWord = groupSplittingArray[0] +": ";
    return firstWord;
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
        dottedValue =  dottedValue+ ""+ value[i];
      }

      return dottedValue + "...";
    }

  }


  static Future<bool> checkInternet() async {
    try {
    final result = await InternetAddress.lookup('https://www.google.com/');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }

    else{
      return false;
    }

    } on SocketException catch (_) {
   return true;
    }
  }







}
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';
import 'color_helper.dart';

class StringHelper{

  static getNotoSansText(String message,{Color? color,FontWeight? font,TextAlign? alignment, double? fontSize,int? maxLines}){
    return  Text(
      message,
      overflow: TextOverflow.ellipsis,
      textAlign: alignment,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.notoSans(
        color: color == null ? White : color,
        fontSize: fontSize == null ? 15 : fontSize,
        fontWeight: font == null ? FontWeight.normal : font,
      ),
    );
  }

   static String splashShow = "splashShow";
   static String mobile = 'mobile';
   static String access_token = "access_token";
   static String refresh_token = "refresh_token";
   static String patientProfile = "patientProfile";
   static String patientName = "patientName";
   static String patientEmail = "patientEmail";
   static String isUsernameLogin = "isUsernameLogin";
   static String citizenId = "citizenId";
   static String recordedAudioPath = "recordedAudioPath";

  Future setPreferenceSplash(bool value)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('${splashShow}', value);
  }
  Future<bool?> getPreferenceSplash()async{
    final prefs = await SharedPreferences.getInstance();
    bool? key =  prefs.getBool('${splashShow}');
    return key;
  }

  Future setMobilePreference({required String mobile_number})async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$mobile', mobile_number);
  }

  Future<String?> getMobile()async{
    final prefs = await SharedPreferences.getInstance();
    String? key =  prefs.getString('${mobile}');
    return key;
  }

  Future setCitizenIdPreference({required String citizen_id})async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$citizenId', citizen_id);
  }

  Future<String?> getCitizenId()async{
    final prefs = await SharedPreferences.getInstance();
    String? key =  prefs.getString('${citizenId}');
    return key;
  }

  Future setRecordedAudioPath({required String path})async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$recordedAudioPath', path);
  }

  Future<String?> getRecordedAudioPath()async{
    final prefs = await SharedPreferences.getInstance();
    String? key =  prefs.getString('${recordedAudioPath}');
    return key;
  }

  Future setTokenPreference({required String accesstoken,required String refreshtoken,})async{
     final prefs = await SharedPreferences.getInstance();
     String access = base64.encode(accesstoken.codeUnits);
     String refresh = base64.encode(refreshtoken.codeUnits);
     prefs.setString('${access_token}', access);
     prefs.setString('${refresh_token}', refresh);
   }

   Future<String> getAccessToken()async{
     final prefs = await SharedPreferences.getInstance();
     String? key =  prefs.getString('${access_token}');
     Uint8List access = base64.decode(key == null ? "" : key);
     return String.fromCharCodes(access);
   }

  Future<String?> getPatientName()async{
     final prefs = await SharedPreferences.getInstance();
     String? key =  prefs.getString('${patientName}');
     return key;
   }
  
  Future setPatientName({required String name})async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$patientName', name);
  }

  Future<String?> getpatientEmail()async{
     final prefs = await SharedPreferences.getInstance();
     String? key =  prefs.getString('${patientEmail}');
     return key;
   }

  Future setpatientEmail({required String mail})async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('$patientEmail', mail);
  }
  Future<bool?> getIsUsernameLogin()async{
    final prefs = await SharedPreferences.getInstance();
    bool? key =  prefs.getBool('${isUsernameLogin}');
    return key;
  }

  Future setIsUsernameLogin({required bool val})async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('$isUsernameLogin', val);
  }

   Future<String> getRefreshToken()async{
     final prefs = await SharedPreferences.getInstance();
     String? key =  prefs.getString('${refresh_token}');
     Uint8List refresh = base64.decode(key == null ? "": key);
     return String.fromCharCodes(refresh);
   }

   Future clearPreferenceData()async{
     final prefs = await SharedPreferences.getInstance();
     prefs.clear();
   }

  Future clearPreferenceDataAndGetOff()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAllNamed(Routes.loginScreen);
  }

}

String getTimeAMPM(String time){
  // print('time $time');
  int hour = int.parse(time.substring(0, 2));
  int minute = int.parse(time.substring(3, 5));
  TimeOfDay time1 = TimeOfDay(hour: hour,minute: minute);
  String hour1 = "";
  if(time1.hourOfPeriod.toString().length == 1){
    hour1 = "0${time1.hourOfPeriod.toString()}";
  } else {
    hour1 = time1.hourOfPeriod.toString();
  }
  String minute1 = "";
  if(time1.minute.toString().length == 1){
    minute1 = "0${time1.minute.toString()}";
  } else {
    minute1 = time1.minute.toString();
  }
  String data = "${hour1}:${minute1}:${time1.period.toString().contains('am') ? 'AM' : 'PM'}";
  return data;
}
String getDateTimeAMPM(String time){
  // print('time $time');
  int hour = int.parse(time.substring(11, 13));
  int minute = int.parse(time.substring(14, 16));
  TimeOfDay time1 = TimeOfDay(hour: hour,minute: minute);
  String hour1 = "";
  if(time1.hourOfPeriod.toString().length == 1){
    hour1 = "0${time1.hourOfPeriod.toString()}";
  } else {
    hour1 = time1.hourOfPeriod.toString();
  }
  String minute1 = "";
  if(time1.minute.toString().length == 1){
    minute1 = "0${time1.minute.toString()}";
  } else {
    minute1 = time1.minute.toString();
  }
  String data = "${hour1}:${minute1}:${time1.period.toString().contains('am') ? 'AM' : 'PM'}";
  return time.substring(0,11) +  data;
}
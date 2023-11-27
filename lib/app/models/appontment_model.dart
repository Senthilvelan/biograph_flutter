import 'dart:convert';

class Appointments {
  String? status;
  String? location;
  String? visitDate;
  String? startTime;
  String? endTime;
  String? caseNotes;
  String? urgencyStatus;
  String? fname;
  String? lName;
  String? meetingServerURL;
  String? meetingRoomDetails;
  String? webXURL;
  String? accessToken;
  String? password;
  Map<String,dynamic>? specialists;

  Appointments({
    this.status,
    this.location,
    this.visitDate,
    this.startTime,
    this.endTime,
    this.caseNotes,
    this.urgencyStatus,
    this.fname,
    this.lName,
    this.meetingServerURL,
    this.meetingRoomDetails,
    this.webXURL,
    this.accessToken,
    this.password,
    this.specialists,
  });

  factory Appointments.fromJson(Map<dynamic, dynamic> jsonData) {
    return Appointments(
      status: jsonData['status'],
      location: jsonData['location'] == null ? "" : jsonData['location'],
      visitDate: jsonData['visitDate'] == null ? "" : jsonData['visitDate'],
      startTime: jsonData['startTime'] == null ? "" : jsonData['startTime'],
      endTime: jsonData['endTime'] == null ? "" : jsonData['endTime'],
      caseNotes: jsonData['caseNotes']== null ? "" : jsonData['caseNotes'],
      urgencyStatus: jsonData['urgencyStatus'],
      fname: jsonData['fname'] == null ? "" : jsonData['fname'],
      lName: jsonData['lName'] == null ? "" : jsonData['lName'],
      meetingServerURL: jsonData['meetingServerURL'],
      meetingRoomDetails: jsonData['meetingRoomDetails'],
      webXURL: jsonData['webXURL'],
      accessToken: jsonData['accessToken'],
      password: jsonData['password'],
      specialists: jsonData['specialists'],
    );
  }

}

class MessageData {
  Data? data;

  MessageData( { this.data});

  factory MessageData.fromJson(Map<dynamic, dynamic> jsonData) {
    return MessageData(
      data: Data.fromJson(jsonData),
    );
  }

  toJson() {
    var data1 = '${data!.toJson()}';
    return data1;
  }
}



class Data {
  String? NotificationLogId;
  String? android_channel_id;
  String? time;
  String? Title;
  // String? PersonId;
  String? NotificationIcon;
  String? message;
  // String? ContantId;
  // String? SendTitle;
  // String? ContantType;

  Data(
      {this.NotificationLogId,
        this.android_channel_id,
        this.time,
        this.Title,
        // this.PersonId,
        this.NotificationIcon,
        this.message,
        // this.ContantId,
        // this.SendTitle,
        // this.ContantType
      });

  factory Data.fromJson(Map<dynamic, dynamic> jsonData) {
    return Data(
      NotificationLogId: jsonData['NotificationLogId'],
      android_channel_id: jsonData['android_channel_id'],
      time: jsonData['time'],
      Title: jsonData['Title'],
      // PersonId: jsonData['PersonId'],
      NotificationIcon: jsonData['NotificationIcon'],
      message: jsonData['message'],
      // ContantId: jsonData['ContantId'],
      // SendTitle: jsonData['SendTitle'],
      // ContantType: jsonData['ContantType'],
    );
  }

  toJson() {
    var data =
        // '{"NotificationLogId":"$NotificationLogId","android_channel_id":"$android_channel_id","time":"$time","Title":"$Title","PersonId":"$PersonId","NotificationIcon":"$NotificationIcon","message":"$message","ContantId":"$ContantId","SendTitle":"$SendTitle","ContantType":"$ContantType"}';
        '{"NotificationLogId":"$NotificationLogId","android_channel_id":"$android_channel_id","time":"$time","Title":"$Title","NotificationIcon":"$NotificationIcon","message":"$message"}';
    return data;
  }
}

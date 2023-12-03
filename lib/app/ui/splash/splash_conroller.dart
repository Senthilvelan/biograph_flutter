import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../models/message_data_model.dart';
import '../../routes/app_pages.dart';
import '../../utils_res/string_helper.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    setChannel();
    Future.delayed(const Duration(seconds: 3), () {
      navigatePage();
    });
    // TODO: implement onInit
    super.onInit();
  }

  navigatePage() async {
    if (await StringHelper().getPreferenceSplash() == null) {
      Get.offAndToNamed(Routes.introScreen);
    } else {
      var AccessToken = await StringHelper().getAccessToken();
      var RefreshToken = await StringHelper().getRefreshToken();
      if (AccessToken!.isNotEmpty && RefreshToken!.isNotEmpty) {
        Get.offAndToNamed(Routes.mainPage);
      } else {
        await StringHelper().clearPreferenceData();
        Get.offAndToNamed(Routes.loginScreen);
      }
    }
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  void setChannel() async {
    // var initializationSettingsAndroid =
    //     new AndroidInitializationSettings('@mipmap/ic_launcher');
    //
    // var initializationSettingsIOS = new IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    //
    // var initializationSettings = new InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);

    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((message) async {
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      await displayNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {});
  }

  Future displayNotification(Map<String, dynamic> message) async {
    MessageData messageData = MessageData.fromJson(message);
    String androidNotifyChannel;
    String title;
    String bodyNotify;
    int NotificationLogId = 0;
    if (Platform.isAndroid) {
      androidNotifyChannel = (message['android_channel_id']);
      NotificationLogId = int.parse(message['NotificationLogId']);
      title = '${message['Title']}';
      bodyNotify = '${message['message']}';
    } else {
      androidNotifyChannel = (message['android_channel_id']);
      NotificationLogId = int.parse(message['NotificationLogId']);
      title = '${message['Title']}';
      bodyNotify = '${message['message']}';
    }

    // var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    //     '$androidNotifyChannel', '$androidNotifyChannel', '',
    //     importance: Importance.max, priority: Priority.high);
    // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    // var platformChannelSpecifics = new NotificationDetails(
    //     android: androidPlatformChannelSpecifics,
    //     iOS: iOSPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.show(
    //   NotificationLogId,
    //   title,
    //   bodyNotify,
    //   platformChannelSpecifics,
    //   payload: '${messageData.toJson()}',
    // );
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {}
  }

  Future onDidRecieveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }
}

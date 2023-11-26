// ignore_for_file: non_constant_identifier_names
library biograph.globalsigleton;

import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/http_service.dart';
import 'network/http_service_impl.dart';

class App {
  static String accessToken = "";

  static late SharedPreferences prefs;

  // static late FirebaseAnalytics analytics;
  static String BASE_URL = "https://oracle.fitx.tech/api/";
  static RxInt total_active_minutes_today = 0.obs;
  static final App _singleton = App._internal();

  static HttpService _httpService = HttpServiceImpl();

  factory App() {
    return _singleton;
  }

  App._internal();

  static Future<void> httpServiceInit() async {
    App._httpService = HttpServiceImpl();
    await App._httpService.init();
    await App._httpService.initNoBase();
  }
}

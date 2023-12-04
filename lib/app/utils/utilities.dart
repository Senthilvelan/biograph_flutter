import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:synchronized/synchronized.dart' as lockSync;

class Utilities {
  static int badgeCount = 0;

  static showBadge() async {
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        badgeCount = badgeCount + 1;
        if (badgeCount <= 0) badgeCount = 1;
        FlutterAppBadger.updateBadgeCount(badgeCount);
      }
    } catch (e) {
      if (kDebugMode)
        print("FlutterAppBadger PlatformException " + e.toString());
    }
  }

  static clearBadge() {
    try {
      // FlutterAppBadger.isAppBadgeSupported().then((res) {
      try {
        if (true) FlutterAppBadger.removeBadge();
      } catch (e) {
        if (kDebugMode) print("PlatformException for FlutterAppBadger");
      }
      // });
    } catch (e) {
      if (kDebugMode) print("PlatformException for FlutterAppBadger");
    }
  }

  Future<void> initDynamicLinks() async {
    print("Initial DynamicLinks");
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    // Incoming Links Listener
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        print("Incoming Link :" + uri.toString());
        //  your code here
      } else {
        print("No Current Links");
        // your code here
      }
    });

    // // Search for Firebase Dynamic Links
    // PendingDynamicLinkData? data = await dynamicLinks
    //     .getDynamicLink(Uri.parse("https://yousite.page.link/refcode"));
    // final Uri uri = data!.link;
    // if (uri != null) {
    //   print("Found The Searched Link: " + uri.toString());
    //   // your code here
    // } else {
    //   print("Search Link Not Found");
    //   // your code here
    // }
  }

  static Future<bool> checkNotiPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (status != PermissionStatus.granted) return false;
    return true;
  }


}

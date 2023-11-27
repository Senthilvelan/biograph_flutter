import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'app/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/ui/splash/splash_page.dart';
import 'app/utils/sizer.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
      Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: HomeBinding(),
            initialRoute: Routes.splashPage,
            defaultTransition: Transition.fadeIn,
            getPages: AppPages.pages,
            home: SplashPage(),
            theme: ThemeData(
              dividerColor: Colors.transparent,
            ),
          );
        },
      )
  );
}

import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/bindings/home_binding.dart';

import 'app/routes/app_pages.dart';

import 'app/ui/splash/splash_page.dart';
import 'app/utils/firebase_options.dart';
import 'app/utils/sizer.dart';
import 'app/utils/utilities.dart';
import 'app/utils_res/color_helper.dart';
import 'app/utils_res/string_helper.dart';

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  // suprsend.showNotification(message.data.toString());

  // suprsend.setSuperProperties(message.data);
  // suprsend.showNotification(payload)
  if (kDebugMode) {
    print("onBackgroundMessage: $message");
  }
  Utilities.showBadge();
} //eof myBackgroundMessageHandler

// final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

// startServer(int serverPort) {
//   var server = Jaguar(port: serverPort, multiThread: true);
//   server.addRoute(serveFlutterAssets());
//   try {
//     server.serve(logRequests: kDebugMode).then((value) {
//       App.setServerPort(serverPort);
//       if (kDebugMode) {
//         print("_serverStarted true ");
//       }
//     });
//   } catch (e) {
//     serverPort += 1;
//     startServer(serverPort);
//   }
// }

// void listenDynamicLinks() async {
//   if (kDebugMode) {
//     print('listenDynamicLinks MAIN - DeepLink Data: called');
//   }
//
//   FlutterBranchSdk.initSession().listen((data) {
//     if (data["\$marketing_title"] != null) {
//       if (kDebugMode) {
//         print('branch: invited_frnd_uuid : ${data["\$marketing_title"]}');
//       }
//       if ("friendInvite".trim().toLowerCase() ==
//           data["\$marketing_title"].toString().trim().toLowerCase()) {
//         App.invitedFriendUuidFromLink = data["\$marketing_title"];
//         StringHelper().setInvitedFrndUuid(data["\$marketing_title"]);
//       }
//     }
//
//     // controllerData.sink.add((data.toString()));
//     if (kDebugMode) {
//       print(data);
//     }
//     if (data['+non_branch_link'] != null &&
//         data['+non_branch_link'].contains("app.biograph.io://")) {
//       FlutterBranchSdk.handleDeepLink(
//           'https://app.biograph.io/${data['+non_branch_link'].replaceAll("app.biograph.io://", '')}');
//       return;
//     }
//     if (kDebugMode) {
//       print(
//           '------------------------------------Link clicked main.dart----------------------------------------------');
//     }
//     if (data['custom_link'] != null) {
//       App.dynamicLinkPath = data['custom_link'];
//       if (kDebugMode) {
//         print("App.dynamicLinkPath: ${App.dynamicLinkPath} updated!");
//       }
//     }
//     if (data['invited_club_uuid'] != null && data['referral_code'] == null) {
//       App.referralClubInviteLink = 'club_link';
//
//       if (kDebugMode) {
//         print(
//             "App.referralClubInviteLink: ${App.referralClubInviteLink} updated!");
//       }
//     } else if (data['invited_club_uuid'] == null &&
//         data['referral_code'] != null) {
//       App.referralClubInviteLink = 'referral_link';
//
//       if (kDebugMode) {
//         print(
//             "App.referralClubInviteLink: ${App.referralClubInviteLink} updated!");
//       }
//     } else if (data['invited_frnd_uuid'] != null) {
//       App.referralClubInviteLink = 'frnd_link';
//
//       if (kDebugMode) {
//         print(
//             "App.referralClubInviteLink: ${App.referralClubInviteLink} updated!");
//       }
//     } else {
//       App.referralClubInviteLink = 'others';
//
//       if (kDebugMode) {
//         print(
//             "listenDynamicLinks App.referralClubInviteLink: ${App.referralClubInviteLink} updated!");
//       }
//     }
//
//     if (data['referral_code'] != null) {
//       if (kDebugMode) {
//         print(
//             'listenDynamicLinks branch: referral_code : ${data['referral_code']}');
//       }
//       StringHelper().setReferredByCode(data['referral_code']);
//     }
//     if (data['invited_club_uuid'] != null) {
//       if (kDebugMode) {
//         print(
//             'listenDynamicLinks branch: invited_club_uuid : ${data['invited_club_uuid']}');
//       }
//       StringHelper().setInvitedClubUuid(data['invited_club_uuid']);
//       if (data['~referring_link'] != null) {
//         Uri uri = Uri.parse(data['~referring_link']);
//         Map<String, String> queryParams = uri.queryParameters;
//         if (queryParams['r'] != null) {
//           if (kDebugMode) {
//             print("data invited_club_uuid referrer code: ${queryParams['r']}");
//           }
//           StringHelper().setReferredByCode(queryParams['r']!);
//         }
//       }
//     }
//
//     if (data['utm_campaign'] != null) {
//       if (kDebugMode) {
//         print('branch: utm_campaign : ${data['utm_campaign']}');
//       }
//       try {
//         StringHelper().setUtmCampaign(data["utm_campaign"]!);
//         StringHelper().setUtmSource(data["utm_source"]!);
//         StringHelper().setUtmMedium(data["utm_medium"]!);
//         if (kDebugMode) {
//           print("App.utmCampaign : ${App.utmCampaign}");
//         }
//         if (App.BASE_URL.contains("oracle")) {
//           SnackBarHelper.errorSnackbar(
//               msg: "Main UTM Param SET",
//               content: 'DeepLink Campaign: ${App.utmCampaign}');
//         }
//       } catch (e) {
//         e.printError();
//       }
//     }
//
//     if (data['\$utm_campaign'] != null) {
//       if (kDebugMode) {
//         print('branch: utm_campaign : ${data['\$utm_campaign']}');
//       }
//       try {
//         StringHelper().setUtmCampaign(data["\$utm_campaign"]!);
//         StringHelper().setUtmSource(data["\$utm_source"]!);
//         StringHelper().setUtmMedium(data["\$utm_medium"]!);
//         if (kDebugMode) {
//           print("App.utmCampaign : ${App.utmCampaign}");
//         }
//         if (App.BASE_URL.contains("oracle")) {
//           SnackBarHelper.errorSnackbar(
//               msg: "Main UTM Param SET",
//               content: 'DeepLink \$Campaign: ${App.utmCampaign}');
//         }
//       } catch (e) {
//         e.printError();
//       }
//     }
//
//     if (kDebugMode) {
//       print('Custom string: ${data}');
//     }
//
//     // print('Custom bool: ${data['custom_bool']}');
//     // print('Custom list number: ${data['custom_list_number']}');
//     if (kDebugMode) {
//       print(
//           '------------------------------------------------------------------------------------------------');
//     }
//     // print('Link clicked: Custom string - ${data['custom_string']}');
//   }, onError: (error) {
//     if (kDebugMode) print('InitSesseion error: ${error.toString()}');
//   });
// }

void main() async {
  //  Starting http server to serve 3D models in js (better three.js support)
  WidgetsFlutterBinding.ensureInitialized();
  // GlobalController.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  App.prefs = await SharedPreferences.getInstance();
  await StringHelper().getAccessToken();
  await StringHelper().getAccountUuid();

  // StringHelper().setAccessToken(
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIzODIyMjk4LCJpYXQiOjE2OTIyODYyOTgsImp0aSI6IjY3ZjVlMmNmOGFhMjQ0NTU5YzIxN2Q3MjU3ZDc5ZDk0IiwidXNlcl9pZCI6NSwidXNlcm5hbWUiOiJhc2hsZXkuc2hhaDEyMzRAZ21haWwuY29tIiwiYWNjb3VudF9pZCI6MjAzLCJsYXN0X3RpbWVzdGFtcCI6MTY5MjI4NjA0MS4xNTY1ODUsImFjY291bnRfdXVpZCI6ImViMDNkNTFkLTMwYjYtNDg2Yy1hM2E0LTU2NjUyMzcwYTBiZCJ9.bTujr1jogf-nEsAsbFeSeUEw_Km2WnFPg1NOe_srQSM");
  // StringHelper().setAccountUuid("eb03d51d-30b6-486c-a3a4-56652370a0bd");
  FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  if (!kDebugMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  // AmplitudeAnalysis.init();
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (initialLink != null) {
    if (kDebugMode) {
      print("initialLink main: $initialLink");

      print("initialLink main: $initialLink");
      print("initialLink main: ${initialLink.utmParameters}");
      print("initialLink main: ${initialLink.android}");
      print("initialLink main: ${initialLink.ios?.asMap().toString()}");
      print("initialLink main: ${initialLink.link}");
      print("initialLink main path: ${initialLink.link.path}");
      print(
          "initialLink main dynamicLinkPath updated: ${initialLink.link.path}");
    }
    try {
      StringHelper().setUtmCampaign(initialLink.utmParameters["utm_campaign"]!);
      StringHelper().setUtmSource(initialLink.utmParameters["utm_source"]!);
      StringHelper().setUtmMedium(initialLink.utmParameters["utm_medium"]!);
      if (kDebugMode) {
        print("App.utmCampaign : ${App.utmCampaign}");
      }
    } catch (e) {
      e.printError();
    }
    StringHelper().setReferredByCodeFromLink(initialLink.link.toString());
    StringHelper().setInvitedClubUuidFromLink(initialLink.link.toString());
    StringHelper().setInvitedFrndUuidFromLink(initialLink.link.toString());

    App.dynamicLinkPath = initialLink.link.toString();
    print(
        "dynamicLinkData main  App.dynamicLinkPath 1 : ${App.dynamicLinkPath}");
  }

  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    if (kDebugMode) {
      print("dynamicLinkData main: $dynamicLinkData");
      print("dynamicLinkData main: $dynamicLinkData");
      print("dynamicLinkData main: ${dynamicLinkData.utmParameters}");
      print("dynamicLinkData main: ${dynamicLinkData.android}");
      print("dynamicLinkData main: ${dynamicLinkData.ios?.asMap().toString()}");
      print("dynamicLinkData main: ${dynamicLinkData.link}");
      print("dynamicLinkData main path: ${dynamicLinkData.link.path}");
    }
    try {
      StringHelper()
          .setUtmCampaign(dynamicLinkData.utmParameters["utm_campaign"]!);
      StringHelper().setUtmSource(dynamicLinkData.utmParameters["utm_source"]!);
      StringHelper().setUtmMedium(dynamicLinkData.utmParameters["utm_medium"]!);
      if (kDebugMode) {
        print("App.utmCampaign : ${App.utmCampaign}");
      }
    } catch (e) {
      e.printError();
    }
    if (dynamicLinkData != null) {
      // if (App.dynamicLinkPath.length <= 0) {
      App.dynamicLinkPath = dynamicLinkData.link.toString();
    }
    if (kDebugMode) {
      print(
          "dynamicLinkData main  App.dynamicLinkPath 2 : ${App.dynamicLinkPath}");
    }

    StringHelper().setReferredByCodeFromLink(App.dynamicLinkPath);
    StringHelper().setInvitedClubUuidFromLink(App.dynamicLinkPath);
    StringHelper().setInvitedFrndUuidFromLink(App.dynamicLinkPath.toString());
  });
  // startServer(9898);
  // startAudioSession();
  // });
  // if (Platform.isIOS) {
  //   setupHealthKitListener();
  // }

  // FlutterUxcam.optIntoSchematicRecordings(); // Confirm that you have user permission for screen recording
  // FlutterUxConfig config = FlutterUxConfig(
  //     userAppKey: "eve1amsw8r0751g",
  //     enableAutomaticScreenNameTagging: false);
  // FlutterUxcam.startWithConfiguration(config);
  MyApp mybiographApp = MyApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      // The following lines are the same as previously explained in "Handling uncaught errors"
      if (!kDebugMode) {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      }

      runApp(mybiographApp);
    }, (error, stack) {
      try {
        if (FirebaseCrashlytics.instance != null) {
          FirebaseCrashlytics.instance.recordError(error, stack);
        }
      } on PlatformException catch (e) {
        if (kDebugMode) print(e);
      } catch (e) {
        if (kDebugMode) print(e);
      }
    });
  });
  // FlutterBranchSdk.validateSDKIntegration();
}

// void setupHealthKitListener() {
//   dynamic platform = const MethodChannel('com.biograph.app.healthkit');
//   print("setupHealthKitListener called");
//   platform.setMethodCallHandler(_handleMethod);
// }
//
// Future<dynamic> _handleMethod(MethodCall call) async {
//   print("setupHealthKitListener _handleMethod called: ${call.method}");
//   print("call.arguments: ${call.arguments}");
//   switch (call.method) {
//     case 'newWorkoutData':
//     // process the workout data
//       print("called newWorkoutData switch block");
//
//       App.httpServiceInit().then((value) {
//         App.httpService.sendAppleHealthDataToServer(call.arguments);
//       });
//       // print("Received new workout data: $totalDistance kcal");
//       break;
//     default:
//       print("Method not recognized");
//   }
// }

// void startAudioSession() async {
//   App.audioSession = await AudioSession.instance;
//   await App.audioSession?.configure(const AudioSessionConfiguration(
//     avAudioSessionCategory: AVAudioSessionCategory.playback,
//     avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
//     avAudioSessionMode: AVAudioSessionMode.defaultMode,
//     avAudioSessionRouteSharingPolicy:
//     AVAudioSessionRouteSharingPolicy.defaultPolicy,
//     avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//     androidAudioAttributes: AndroidAudioAttributes(
//       contentType: AndroidAudioContentType.music,
//       flags: AndroidAudioFlags.none,
//       usage: AndroidAudioUsage.media,
//     ),
//     androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
//     androidWillPauseWhenDucked: true,
//   ));
// }

/*void startAudioSession() async {
  App.audioSession = await AudioSession.instance;
  await App.audioSession?.configure(const AudioSessionConfiguration(
    avAudioSessionCategory: AVAudioSessionCategory.playback,
    avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
    avAudioSessionMode: AVAudioSessionMode.defaultMode,
    avAudioSessionRouteSharingPolicy:
        AVAudioSessionRouteSharingPolicy.defaultPolicy,
    avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
    androidAudioAttributes: AndroidAudioAttributes(
      contentType: AndroidAudioContentType.music,
      flags: AndroidAudioFlags.none,
      usage: AndroidAudioUsage.media,
    ),
    androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
    androidWillPauseWhenDucked: true,
  ));
}*/

void listenInternet(BuildContext context) {
  InternetConnectionCheckerPlus().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        App.internetNotAvail.value = false;
        if (kDebugMode) print("internetNotAvail ${App.internetNotAvail.value}");
        break;
      case InternetConnectionStatus.disconnected:
        App.internetNotAvail.value = true;
        if (kDebugMode) print("internetNotAvail ${App.internetNotAvail.value}");
        break;
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print("STATE  ${state.name}");
      print("MAIN didChangeAppLifecycleState() + state.name");
    }

    // setState(() {
    //   _notification = state;
    // });
    switch (state) {
      case AppLifecycleState.resumed:
        // AmplitudeAnalysis.logEvent20("App in foreground", eventProperties: {});
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        // AmplitudeAnalysis.logEvent20("App in Background", eventProperties: {});
        break;
      case AppLifecycleState.detached:
        // AmplitudeAnalysis.logEvent20("App Detached", eventProperties: {});
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    App.buildContext = context;
    listenInternet(context);

    //todo need to check this with design
    App.httpServiceInit();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Sizer(
      builder: (context, orientation, deviceType) {
        App.analytics = FirebaseAnalytics.instance;
        // FirebaseAnalyticsObserver observer =
        //     FirebaseAnalyticsObserver(analytics: App.analytics);
        if (Platform.isAndroid) {
          MethodChannel channel =
              const MethodChannel("com.biograph.app/buildconfig");
          channel.invokeMethod("getBaseEndpoint").then((result) {
            App.BASE_URL = result;
          });
        }
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   DeviceOrientation.portraitDown,
        // ]);
        // if (Platform.isIOS) {
        //   initUniLinks();
        // }
        // listenDynamicLinks();
        SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
        return ScreenUtilInit(
          builder: (context, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialBinding: HomeBinding(),
              initialRoute: Routes.splashPage,
              navigatorKey: NavigationService.navigatorKey,
              defaultTransition: Transition.cupertino,
              transitionDuration: const Duration(milliseconds: 300),
              getPages: AppPages.pages,
              // navigatorObservers: <NavigatorObserver>[observer],
              // navigatorObservers: [routeObserver],
              navigatorObservers: [MyRouteObserver()],
              home: SplashPage(),
              theme: ThemeData(
                dividerColor: Colors.transparent,
                fontFamily: "Roboto",
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: primaryBlackColor,
                ),
                backgroundColor: Colors.black87,
              ),
            );
          },
          minTextAdapt: true,
          designSize: const Size(390, 844),
        );
      },
    );
  }

  // Future<void> initUniLinks() async {
  //   if (kDebugMode) {
  //     print("initUniLinks called");
  //   }
  //   // ... check initialLink
  //   try {
  //     final initialLink = await getInitialLink();
  //     // Parse the link and warn the user, if it is not correct,
  //     // but keep in mind it could be `null`.
  //     if (initialLink != null) {
  //       if (kDebugMode) {
  //         print("initUniLinks found $initialLink");
  //       }
  //       App.dynamicLinkPath = initialLink.toString();
  //       if (App.dynamicLinkPath.contains("app.biograph.io://")) {
  //         FlutterBranchSdk.handleDeepLink(
  //             'https://app.biograph.io/${App.dynamicLinkPath.replaceAll("app.biograph.io://", '')}');
  //       }
  //
  //       StringHelper()
  //           .setReferredByCodeFromLink(App.dynamicLinkPath.toString());
  //       try {
  //         StringHelper().setUtmCampaign(Uri.parse(initialLink.toString())
  //             .queryParameters["utm_campaign"]!);
  //         StringHelper().setUtmSource(
  //             Uri.parse(initialLink.toString()).queryParameters["utm_source"]!);
  //         StringHelper().setUtmMedium(
  //             Uri.parse(initialLink.toString()).queryParameters["utm_medium"]!);
  //         if (kDebugMode) {
  //           print("App.utmCampaign : ${App.utmCampaign}");
  //         }
  //       } catch (e) {
  //         e.printError();
  //       }
  //       if (kDebugMode) {
  //         print("Initial Link received: $initialLink");
  //       }
  //     }
  //   } on PlatformException catch (exception) {
  //     // Handle exception by warning the user their action did not succeed
  //     if (kDebugMode) {
  //       print("Initial Link error occurred: $exception");
  //     }
  //   }
  //
  //   // Attach a listener to the stream
  //   linkStream.listen((String? link) {
  //     if (link != null) {
  //       App.dynamicLinkPath = link.toString();
  //       if (App.dynamicLinkPath.contains("app.biograph.io://")) {
  //         FlutterBranchSdk.handleDeepLink(
  //             'https://app.biograph.io/${App.dynamicLinkPath.replaceAll("app.biograph.io://", '')}');
  //       }
  //       StringHelper()
  //           .setReferredByCodeFromLink(App.dynamicLinkPath.toString());
  //       try {
  //         StringHelper().setUtmCampaign(
  //             Uri.parse(link.toString()).queryParameters["utm_campaign"]!);
  //         StringHelper().setUtmSource(
  //             Uri.parse(link.toString()).queryParameters["utm_source"]!);
  //         StringHelper().setUtmMedium(
  //             Uri.parse(link.toString()).queryParameters["utm_medium"]!);
  //         if (kDebugMode) {
  //           print("App.utmCampaign : ${App.utmCampaign}");
  //         }
  //       } catch (e) {
  //         e.printError();
  //       }
  //       if (kDebugMode) {
  //         print("Link stream event received: $link");
  //       }
  //     }
  //   }, onError: (err) {
  //     // Handle exception by warning the user their action did not succeed
  //     if (kDebugMode) {
  //       print("Link stream event error occurred: $err");
  //     }
  //   });
  // }

  void registerFcmToken() async {
    if (Platform.isAndroid) {
      String? token = await FirebaseMessaging.instance.getToken();
      // suprsend.setAndroidFcmPush(token!);
      if (kDebugMode) print("freshChatFun 9 FCM Token is generated $token");
    }
  } //eof registerFcmToken
}

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) {
    NavigationService.screenName = route.settings.name!;
    if (NavigationService.screenName != null) {}
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      _sendScreenView(route);
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    /*if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }*/
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    /*if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }*/
    super.didPop(route, previousRoute);
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String screenName = "";
}

// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'app/bindings/home_binding.dart';
// import 'app/routes/app_pages.dart';
// import 'app/ui/splash/splash_page.dart';
// import 'app/utils/sizer.dart';
//
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   runApp(
//       Sizer(
//         builder: (context, orientation, deviceType) {
//           return GetMaterialApp(
//             debugShowCheckedModeBanner: false,
//             initialBinding: HomeBinding(),
//             initialRoute: Routes.splashPage,
//             defaultTransition: Transition.fadeIn,
//             getPages: AppPages.pages,
//             home:  SplashPage(),
//             theme: ThemeData(
//               dividerColor: Colors.transparent,
//             ),
//           );
//         },
//       )
//   );
// }

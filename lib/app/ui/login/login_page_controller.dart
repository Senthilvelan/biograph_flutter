import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app.dart';
import '../../utils_res/font_family.dart';
import '../../utils_res/string_helper.dart';

class LoginPageController extends GetxController {
  FToast ftoast = FToast();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late User _user;

  bool isSignIn = false;
  bool google = false;

  LoginPageController() {
    getCountry();

    StringHelper().getReferredByCode().then((referredByCode) {
      // if (referredByCode == null || referredByCode.isEmpty) {
      //   AppsflyerAnalysis.getFbData();
      // }
    });
  }

  Future<String> getCountry() async {
    dynamic response =
        await App.httpService.getRequestNoBase("https://ipinfo.io/json");
    App.ipData = response.data;
    return "";
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  var arguments = Get.arguments;

  setLoading(bool value) {
    _isLoading = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // initFirstRun();
  }

  void showToast(String msg, bool success) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color(0xff263545),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            success ? "assets/ic_thumb_up.png" : "assets/ic_error_icon.png",
            height: 24,
            // width: 52,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            msg,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: FontFamily.INTER,
              fontWeight: FontWeight.w400,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    );
    ftoast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  Future<dynamic> signInWithGoogle() async {
    App.loginMtd = "google";

    final GoogleSignInAccount? googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth;
      try {
        googleAuth = await googleUser?.authentication;
      } catch (e) {
        await _googleSignIn.signOut();
        return;
      }
      if (googleAuth?.accessToken == null && googleAuth?.idToken == null) {
        return;
      }
      //todo check google token
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      setLoading(true);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      _user = FirebaseAuth.instance.currentUser!;
      if (_user != null) {
        // _user.getIdToken(false).then((value) => {getServerToken(value, 0, "")});
      } else {
        setLoading(false);
      }
    } on PlatformException catch (e) {
      print('error caught: $e');
      setLoading(false);
      return;
    } catch (e) {
      print('error caught: $e');
      setLoading(false);
      return;
    }

    // Once signed in, return the UserCredential
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

// Future<dynamic> signInWithApple() async {
//   App.loginMtd = "apple";
//
//
//   // To prevent replay attacks with the credential returned from Apple, we
//   // include a nonce in the credential request. When signing in with
//   // Firebase, the nonce in the id token returned by Apple, is expected to
//   // match the sha256 hash of `rawNonce`.
//   final rawNonce = generateNonce();
//   final nonce = sha256ofString(rawNonce);
//
//   // Request credential for the currently signed in Apple account.
//   final AuthorizationCredentialAppleID appleCredential =
//       await SignInWithApple.getAppleIDCredential(
//     scopes: [
//       AppleIDAuthorizationScopes.email,
//       AppleIDAuthorizationScopes.fullName,
//     ],
//     nonce: nonce,
//   );
//   setLoading(true);
//   // Create an `OAuthCredential` from the credential returned by Apple.
//   final oauthCredential = OAuthProvider("apple.com").credential(
//     idToken: appleCredential.identityToken,
//     rawNonce: rawNonce,
//   );
//
//   // Sign in the user with Firebase. If the nonce we generated earlier does
//   // not match the nonce in `appleCredential.identityToken`, sign in will fail.
//   // return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//   UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//   _user = FirebaseAuth.instance.currentUser!;
//   String? givenName = appleCredential.givenName;
//   String? familyName = appleCredential.familyName;
//   givenName ??= "";
//   familyName ??= "";
//   print("displayName: $givenName familyName: $familyName");
//   if (_user != null) {
//     _user.getIdToken(false).then((value) =>
//         {getServerToken(value, 2, "$givenName $familyName".trim())});
//   } else {
//     setLoading(false);
//   }
// }

// void getServerToken(token, typeValue, String displayName) async {
//   await FirebaseAuth.instance.signOut();
//   if (typeValue == 0) {
//     await _googleSignIn.signOut();
//   }
//   String? device_id = await App.getDeviceId();
//   device_id ??= "";
//   await Future.delayed(const Duration(milliseconds: 50));
//   await Future.wait([
//     StringHelper().getUtmCampaign(),
//     StringHelper().getUtmSource(),
//     StringHelper().getUtmMedium(),
//     StringHelper().getInvitedClubUuid(),
//   ]);
//   dynamic data = jsonEncode({
//     "auth_type": 0,
//     "google_token": "$token",
//     "invited_club_uuid": App.invitedClubUuidFromLink,
//     "referral_code": App.referredByCode,
//     "time_zone": DateTime.now().timeZoneName.toString(),
//     "time_zone_offset": DateTime.now().timeZoneOffset.toString(),
//     "ip_data": App.ipData,
//     "utm_campaign": App.utmCampaign,
//     "utm_medium": App.utmMedium,
//     "utm_source": App.utmSource,
//     "displayName": displayName,
//     "device_id": device_id,
//   });
//   if (kDebugMode) print(data);
//   if (kDebugMode) print("token: $token");
//   var otpResponse = await App.httpService
//       .postRequest1(GET_ACCESS_TOKEN, postData: data)
//       .onError((error, stackTrace) {
//     return setLoading(false);
//   });
//   print(otpResponse.data);
//   if (otpResponse.statusCode == 200) {
//     var otpResponseData = otpResponse.data["data"];
//     if (otpResponseData.length == 0) {
//       GeneralWidgets.customToast(
//         message: 'Please enter  OTP',
//         imgPath: Emojis.sadFace,
//       );
//       return;
//     }
//     if (otpResponseData['onboarding_variant'] != null) {
//       StringHelper()
//           .setOnBoardingVariant(otpResponseData['onboarding_variant']);
//     }
//     App.accessToken = otpResponseData["access_token"];
//     App.accountUuid = otpResponseData["account_uuid"];
//     try {
//       App.newUserBool = otpResponseData["is_new_user"];
//     } catch (e) {
//       print("Exce" + e.toString());
//     }
//     if (App.newUserBool) {
//       App.invitedClubUuidFromLink = "";
//     }
//     bool new_account_created = false;
//
//     try {
//       new_account_created = otpResponseData["new_account_created"];
//     } catch (e) {
//       print("Exce$e");
//     }
//     // App.accountActivated = otpResponseData["account_active"];
//     String emailData = "";
//     try {
//       emailData = otpResponseData["email"];
//     } catch (e) {}
//
//     await StringHelper().setUserData(
//         "",
//         emailData,
//         otpResponseData["user_id"].toString(),
//         otpResponseData["account_uuid"],
//         otpResponseData["access_token"],
//         otpResponseData["refresh_token"]);
//     try {
//       StringHelper().setUserEmailFirebase(emailData);
//     } catch (e) {}
//
//     String onboarding_variant = "";
//     if (otpResponseData['onboarding_variant'] != null) {
//       // App.onboarding_variant = otpResponseData['onboarding_variant'];
//       onboarding_variant = otpResponseData['onboarding_variant'];
//       StringHelper()
//           .setOnBoardingVariant(otpResponseData['onboarding_variant']);
//     }
//
//
//     await Future.delayed(const Duration(milliseconds: 100));
//     await App.httpService.init();
//     await Future.delayed(const Duration(milliseconds: 300));
//     //Need to init to update the header
//     await App.httpService.get_global_config();
//     App.httpService
//         .getUserProfile('welcomepage controller getServerToken',
//             needWait: true)
//         .then((response) async {
//       if (response == null) {
//         AmplitudeAnalysis.logEvent20("Welcome Page Stuck", eventProperties: {
//           "appVersion": App.version,
//           "osType": Platform.operatingSystem,
//           "user_profile_response": "null",
//         });
//         setLoading(false);
//         return;
//       }
//       if (response.statusCode != 200) {
//         setLoading(false);
//         return;
//       }
//
//       await Future.delayed(const Duration(milliseconds: 100));
//       if (App.firstName.isEmpty) {
//         App.firstTimeUserHomePage = true.obs;
//         // try {
//         //   AmplitudeAnalysis.logEvent20("New User Signed Up", eventProperties: {
//         //     "appVersion": App.version,
//         //     "osType": Platform.operatingSystem,
//         //     "email": otpResponseData["email"],
//         //     "method": App.loginMtd,
//         //     "isNewUser": App.newUserBool,
//         //   });
//         // } catch (e) {}
//
//
//
//         Get.offAllNamed(Routes.usernamePage);
//         return;
//       }
//
//       bool isNotiEnabled = await Utilities.checkNotiPermission();
//
//       if (!App.avatarCreated) {
//         Get.offAllNamed(Routes.pickFacePage);
//         return;
//       }
//
//
//       App.gotoMain(0);
//     });
//   } else {
//     setLoading(false);
//   } //eof if...else
// }

// void initFirstRun() async {
//   final prefs = await SharedPreferences.getInstance();
//   if (prefs.getBool('first_run_fitmint2.0') ?? true) {
//     print("DELETING ON FIRST RUN");
//     SingletonSecureStorage().deleteAll();
//     prefs.setBool('first_run_fitmint2.0', false);
//   }
//   if (App.referredByCode.isEmpty) {
//     StringHelper().getReferredByCode().then((value) {
//       if (App.referredByCode.isEmpty) {
//         Future.delayed(const Duration(seconds: 2), () {
//           if (App.referredByCode.isEmpty) {
//             StringHelper().getReferredByCode().then((value) {});
//           }
//         });
//       }
//     });
//   }
// }
}

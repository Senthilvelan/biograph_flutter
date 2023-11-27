import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart' as enc;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:suprsend_flutter_sdk/suprsend.dart';
// import 'package:web3dart/crypto.dart';
// import 'package:web3dart/web3dart.dart';

import '../app.dart';
import '../routes/app_pages.dart';
import 'color_helper.dart';

class StringHelper {
  static String splashShow = "splashShow";
  static String mobile = 'mobile';
  static String height = 'height';
  static String weight = 'weight';
  static String last_level = 'last_level';

  static String fit_enabled = 'fit_enabled';

  static String refresh_token_old = "refresh_token_old";
  static String is_username_login = "is_username_login";

  static String atTimeStamp = "atTimeStamp";

  static String wpe_key = "wpe_key";
  static String first_name_key = "first_name_key";
  static String email_key = "email_key";
  static String account_uuid_key = "account_uuid_key";
  static String referredByCode = "referredByCode";
  static String access_token_key = "access_token_key";
  static String last_account_uuid = "last_account_uuid";
  static String avatar_glb_file_path = "avatar_glb_file_path";
  static String refresh_token_key = "refresh_token_key";
  static String user_id_key = "user_id_key";

  static String address_key = "address";
  static String private_key = "private_key";
  static String public_key = "public_key";
  static String seed_words_key = "seed_words_key";

  static String energy_refill_amount = "energy_refill_amount";

  static String is_shown_staking_pitch = "is_shown_staking_pitch";
  static String is_shown_durability_intro = "is_shown_durability_intro";
  static String is_shown_crafting_intro = "is_shown_crafting_intro";
  static String should_show_copy_msg_bottom_sheet =
      "should_show_copy_msg_bottom_sheet";
  static String should_show_direct_counter = "should_show_direct_counter";
  static String done_first_time_bubble_bs = "done_first_time_bubble_bs";

  static String in_app_anouncement_expdate = "in_app_anouncement_expdate";

  static String increased_wardrobe_capacity =
      'origin_pass_increased_capacity_close';
  static String max_wardrobe_capacity = 'storage_full_close';
  static String setReferralCapacityKey = 'setReferralCapacity';

  static String is_audio_on = "is_audio_on";
  static String is_audio_min = "is_audio_min";
  static String is_audio_km = "is_audio_km";
  static String kmEnabled = "kmEnabled";

  // static String access_token = "access_token";
  // static String refresh_token = "refresh_token";
  // static String is_shown_promo_mint_key = "is_shown_promo_mint_key";
  // static String is_shown_promo_mint_key_auto = "is_shown_promo_mint_key_auto";

  Future setUserData(String first_name, String email, String user_id,
      String account_uuid, String access_token, String refresh_token) async {
    App.accountUuid = account_uuid;
    App.firstName = first_name;
    await getLastAccountUuid().then((value) {
      if (value!.isEmpty) {
        return;
      }
      if (value != account_uuid) {
        SingletonSecureStorage().deleteAll();
      }
    });
    App.accessToken = access_token;
    App.accountUuid = account_uuid;

    SingletonSecureStorage().write(key: first_name_key, value: first_name);
    SingletonSecureStorage().write(key: email_key, value: email);
    SingletonSecureStorage().write(key: user_id_key, value: user_id);

    SingletonSecureStorage().write(key: account_uuid_key, value: account_uuid);
    SingletonSecureStorage().write(key: access_token_key, value: access_token);
    SingletonSecureStorage()
        .write(key: refresh_token_key, value: refresh_token);
    App.prefs.setString(account_uuid_key, account_uuid);
    App.prefs.setString(access_token_key, access_token);
  }

  Future<void> setUserEmailFirebase(String user_email) async {
    App.analytics.setUserId(id: user_email);
  }
  //
  // Future<void> setUserWalletFirebase() async {
  //   if (MyWallet.myWalletAddress.isNotEmpty) {
  //     App.analytics.setUserProperty(
  //         name: "wallet_address",
  //         value:
  //         "${MyWallet.myWalletAddress.substring(0, 10)}...${MyWallet.myWalletAddress.substring(32, 42)}");
  //   }
  // }

  Future<void> sendAnalyticsEvent(String event_name) async {
    App.analytics.logEvent(
      name: event_name,
      parameters: <String, dynamic>{
        // 'string': 'string',
        // 'int': 42,
        // 'long': 12345678910,
        // 'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        // 'bool': true.toString(),
        // 'items': [itemCreator()]
      },
    );
  }

  //is_crafting_intro_shown
  Future setIs_shown_crafting_intro(String value) async {
    SingletonSecureStorage().write(key: is_shown_crafting_intro, value: value);
  }

  Future<String?> getIs_shown_crafting_intro() async {
    return SingletonSecureStorage().read(key: is_shown_crafting_intro);
  }

  //is_shown_staking_pitch
  static Future setIs_shown_staking_pitch(String value) async {
    SingletonSecureStorage().write(key: is_shown_staking_pitch, value: value);
  }

  static Future<String?> getIs_shown_staking_pitch() async {
    return SingletonSecureStorage().read(key: is_shown_staking_pitch);
  }

  static const String aqOff = "0";
  static const String aqOnTime = "1";
  static const String aqOnDist = "2";

  //is_audio_on
  static Future setIs_audio_on(String value) async {
    App.prefs.setString(is_audio_on, value);
  }

  static Future<String?> getIs_audio_on() async {
    String isAudioOnLocal = await getIs_audio_on_local();
    if (isAudioOnLocal.isEmpty) {
      return aqOnDist;
    }
    return isAudioOnLocal;
  }

  static Future<String> getIs_audio_on_local() async {
    String? temp = App.prefs.getString(is_audio_on);
    temp ??= "";
    return temp;
  }

  static const String minTwoMin = "2";
  static const String minFiveMin = "5";
  static const String minTenMin = "10";

  //is_audio_min
  static Future setIs_audio_min(String value) async {
    await setKmEnabled(false.toString());
    App.prefs.setString(is_audio_min, value);
  }

  static Future<String?> getIs_audio_min() async {
    return App.prefs.getString(is_audio_min);
  }

  static const String kmHalf = ".5";
  static const String kmOne = "1";
  static const String kmTwo = "2";

  //is_audio_km
  static Future setIs_audio_km(String value) async {
    print("setIs_audio_km called with $value");
    await setKmEnabled(true.toString());
    App.prefs.setString(is_audio_km, value);
  }

  static Future<String?> getIs_audio_km() async {
    return App.prefs.getString(is_audio_km);
  }

  //kmEnabled
  static Future setKmEnabled(String value) async {
    App.prefs.setString(kmEnabled, value);
  }

  static Future<String?> getKmEnabled() async {
    String? isKmEnabled = await getKmEnabledLocal();
    if (isKmEnabled == null) {
      return "true";
    }

    if (isKmEnabled.isEmpty) {
      return "true";
    }
    return isKmEnabled;
  }

  static Future<String?> getKmEnabledLocal() async {
    return App.prefs.getString(kmEnabled);
  }

  //is_shown_durability_intro
  Future setIs_shown_durability_intro(String value) async {
    SingletonSecureStorage()
        .write(key: is_shown_durability_intro, value: value);
  }

  Future<String?> getIs_shown_durability_intro() async {
    return SingletonSecureStorage().read(key: is_shown_durability_intro);
  }

  //should show copy important msg bottom
  Future setShowCopyBottomSheetFlag(String value) async {
    SingletonSecureStorage()
        .write(key: should_show_copy_msg_bottom_sheet, value: value);
  }

  Future<String?> getShowCopyBottomSheetFlag() async {
    return SingletonSecureStorage()
        .read(key: should_show_copy_msg_bottom_sheet);
  }

  //should_show_direct_counter
  Future setShowDirectConter(bool value) async {
    // SingletonSecureStorage()
    //     .write(key: '$should_show_direct_counter', value: value);
    App.prefs.setBool(should_show_direct_counter, value);
  }

  Future<bool> getShowDirectConter() async {
    bool? temp = App.prefs.getBool(should_show_direct_counter);
    temp ??= false;
    return temp;
  }

  //done_first_time_bubble_bs
  Future setFirtTimeBubble(String value) async {
    //TODO :Testing
    SingletonSecureStorage()
        .write(key: done_first_time_bubble_bs, value: value);
  }

  Future<String?> getFirstTimeBubble() async {
    return SingletonSecureStorage().read(key: done_first_time_bubble_bs);
  }

  static Future<bool> getFirstTimeBubbleFs() async {
    String? isDone = await StringHelper().getFirstTimeBubble();
    // isShown ??= "";
    // return false;
    if (isDone != null) {
      if (isDone.toString().toLowerCase() == true.toString().toLowerCase()) {
        return false;
      }
    }
    return true;
  }

  //in_app_anouncement_expdate
  Future setInAppAnouncementExpDate(String date) async {
    SingletonSecureStorage()
        .write(key: in_app_anouncement_expdate, value: date);
  }

  Future<String?> getInAppAnouncementExpDate() async {
    return SingletonSecureStorage().read(key: in_app_anouncement_expdate);
  }

  //user_id_key
  Future setUserId(String user_id) async {
    SingletonSecureStorage().write(key: user_id_key, value: user_id);
  }

  Future<String?> getUserId() async {
    return SingletonSecureStorage().read(key: user_id_key);
  }

  //wpe
  Future setWpe(String wpe) async {
    SingletonSecureStorage().write(key: wpe_key, value: wpe);
  }

  Future<String?> getWpe() async {
    return SingletonSecureStorage().read(key: wpe_key);
  }

  //email
  Future setEmail(String email) async {
    SingletonSecureStorage().write(key: email_key, value: email);
  }

  Future<String?> getEmail() async {
    return SingletonSecureStorage().read(key: email_key);
  }

  //frndInvite
  Future setInvitedFrndUuidFromLink(String link) async {
    if (link.contains("https://fitmint.io/?frnd_id=")) {
      if (kDebugMode) {
        print("saving dynamicLinkData: $link");
      }
      String invited_frnd_uuid =
      link.replaceAll("https://fitmint.io/?frnd_id=", "");
      if (kDebugMode) {
        print("invited_club_uuid $invited_frnd_uuid");
      }
      getInvitedFrndUuid().then((value) {
        if (value == null) {
          return;
        }
        if (value.isEmpty) {
          setInvitedFrndUuid(invited_frnd_uuid);
        }
      });
    } else {
      if (kDebugMode) {
        print("not saving dynamicLinkData: ${link}");
      }
    }
  }

  Future setInvitedFrndUuid(String value) async {
    print("invitedfrndUuidFromLink: SAVED : $value");
    App.invitedFriendUuidFromLink = value;
    SingletonSecureStorage()
        .write(key: 'invitedFriendUuidFromLink', value: value);
  }

  Future<String> getInvitedFrndUuid() async {
    if (App.invitedFriendUuidFromLink.isEmpty) {
      App.invitedFriendUuidFromLink =
      await SingletonSecureStorage().read(key: 'invitedFriendUuidFromLink');
    }
    return App.invitedFriendUuidFromLink;
  }

  //clubInvite
  Future setInvitedClubUuidFromLink(String link) async {
    if (link.contains("https://fitmint.io/?club_id=")) {
      if (kDebugMode) {
        print("saving dynamicLinkData: $link");
      }
      String invited_club_uuid =
      link.replaceAll("https://fitmint.io/?club_id=", "");
      if (kDebugMode) {
        print("invited_club_uuid $invited_club_uuid");
      }
      getInvitedClubUuid().then((value) {
        if (value == null) {
          return;
        }
        if (value.isEmpty) {
          setInvitedClubUuid(invited_club_uuid);
        }
      });
    } else {
      if (kDebugMode) {
        print("not saving dynamicLinkData: ${link}");
      }
    }
  }

  Future setInvitedClubUuid(String value) async {
    print("invitedClubUuidFromLink: SAVED : $value");
    App.invitedClubUuidFromLink = value;
    SingletonSecureStorage()
        .write(key: 'InvitedClubUuidFromLink', value: value);
  }

  Future<String> getInvitedClubUuid() async {
    if (App.invitedClubUuidFromLink.isEmpty) {
      App.invitedClubUuidFromLink =
      await SingletonSecureStorage().read(key: 'InvitedClubUuidFromLink');
    }
    return App.invitedClubUuidFromLink;
  }

  //referredByCode
  Future setReferredByCodeFromLink(String link) async {
    if (link.contains("https://fitmint.io/?referral_code=")) {
      if (kDebugMode) {
        print("saving dynamicLinkData: $link");
      }
      String referral_code =
      link.replaceAll("https://fitmint.io/?referral_code=", "");
      if (kDebugMode) {
        print("referral_code $referral_code");
      }
      getReferredByCode().then((value) {
        if (value == null) {
          return;
        }
        if (value!.isNotEmpty) {
          StringHelper().setReferredByCode(referral_code);
        }
      });
    } else {
      if (kDebugMode) {
        print("not saving dynamicLinkData: ${link}");
      }
    }
  }

  Future setReferredByCode(String value) async {
    print("referredByCode: SAVED : $value");
    App.referredByCode = value;
    SingletonSecureStorage().write(key: referredByCode, value: value);
  }

  Future<String> getReferredByCode() async {
    if (App.referredByCode.isNotEmpty) {
      return App.referredByCode;
    }
    String? temp = await SingletonSecureStorage().read(key: referredByCode);
    temp ??= "";
    App.referredByCode = temp;
    return App.referredByCode;
  }

  Future setOnBoardingVariant(String value) async {
    print("setOnBoardingVariant: SAVED : $value");
    App.onboarding_variant = value;
    SingletonSecureStorage().write(key: 'onboarding_variant', value: value);
  }

  Future<String> getOnBoardingVariant() async {
    if (App.onboarding_variant.isEmpty) {
      App.onboarding_variant =
      await SingletonSecureStorage().read(key: 'onboarding_variant');
    }
    return App.onboarding_variant;
  }

  Future setUtmSource(String value) async {
    if (value.isEmpty) return;
    App.utmSource = value;
    SingletonSecureStorage().write(key: 'utmSource', value: value);
  }

  Future<String> getUtmSource() async {
    if (App.utmSource.isEmpty) {
      App.utmSource = await SingletonSecureStorage().read(key: 'utmSource');
    }
    return App.utmSource;
  }

  Future setUtmCampaign(String value) async {
    if (value.isEmpty) return;
    App.utmCampaign = value;
    SingletonSecureStorage().write(key: 'utmCampaign', value: value);
  }

  Future<String> getUtmCampaign() async {
    if (App.utmCampaign.isEmpty) {
      App.utmCampaign = await SingletonSecureStorage().read(key: 'utmCampaign');
    }
    return App.utmCampaign;
  }

  Future setUtmMedium(String value) async {
    if (value.isEmpty) return;
    App.utmMedium = value;
    SingletonSecureStorage().write(key: 'utmMedium', value: value);
  }

  Future<String> getUtmMedium() async {
    if (App.utmMedium.isEmpty) {
      App.utmMedium = await SingletonSecureStorage().read(key: 'utmMedium');
    }
    return App.utmMedium;
  }

  //account_uuid
  Future setAccountUuid(String account_uuid) async {
    App.accountUuid = account_uuid;
    if (App.prefs != null) {
      App.prefs.setString(account_uuid_key, account_uuid);
    }
    SingletonSecureStorage().write(key: account_uuid_key, value: account_uuid);
  }

  Future<String> getAccountUuid() async {
    if (App.accountUuid.isNotEmpty) {
      return App.accountUuid;
    }
    if (App.prefs != null) {
      String? temp = App.prefs.getString(account_uuid_key);
      temp ??= "";
      App.accountUuid = temp;
    }
    if (App.accountUuid.isEmpty) {
      App.accountUuid =
      await SingletonSecureStorage().read(key: account_uuid_key);
      if (App.accessToken.isNotEmpty) {
        if (App.prefs != null) {
          App.prefs.setString(account_uuid_key, App.accountUuid);
        }
      }
    }

    if (kDebugMode) {
      print("App.accountUuid is Set now ");
    }
    return App.accountUuid;
  }

  //access_token
  Future setAccessToken(String access_token) async {
    App.accessToken = access_token;
    if (App.prefs != null) {
      App.prefs.setString(access_token_key, access_token);
    }
    SingletonSecureStorage().write(key: access_token_key, value: access_token);
  }

  Future setLastAccountUuid(String account_uuid) async {
    SingletonSecureStorage().write(key: last_account_uuid, value: account_uuid);
  }

  Future<String?> getLastAccountUuid() async {
    return SingletonSecureStorage().read(key: last_account_uuid);
  }

  Future setWeeklyRecapOff(String key) async {
    App.prefs!.setBool("weekly_recap_off_${key}", true);
  }

  bool getWeeklyRecapOff(String key) {
    bool? result = App.prefs!.getBool("weekly_recap_off_${key}");
    result ??= false;
    return result;
  }

  Future setMonthlyRecapOff(String key) async {
    App.prefs!.setBool("monthly_recap_off_${key}", true);
  }

  bool getMonthlyRecapOff(String key) {
    bool? result = App.prefs!.getBool("monthly_recap_off_${key}");
    result ??= false;
    return result;
  }

  Future<String?> getAccessToken() async {
    if (App.accessToken.isNotEmpty) {
      return App.accessToken;
    }
    if (App.prefs != null) {
      String? temp = App.prefs.getString(access_token_key);
      temp ??= "";
      App.accessToken = temp;
    }
    if (App.accessToken.isEmpty) {
      App.accessToken =
      await SingletonSecureStorage().read(key: access_token_key);
      if (App.accessToken.isNotEmpty) {
        if (App.prefs != null) {
          App.prefs.setString(access_token_key, App.accessToken);
        }
      }
    }

    if (kDebugMode) {
      print("App.accessToken is Set now ");
    }
    return App.accessToken;
  }

  //refresh_token
  Future setRefreshToken(String refresh_token) async {
    SingletonSecureStorage()
        .write(key: refresh_token_key, value: refresh_token);
  }

  Future<String?> getRefreshToken() async {
    return SingletonSecureStorage().read(key: refresh_token_key);
  }

  //address
  // Future setAddress(String address) async {
  //   MyWallet.myWalletAddress = address;
  //   SingletonSecureStorage().write(key: address_key, value: address);
  // }
  //
  // Future<String?> getAddress() async {
  //   if (MyWallet.myWalletAddress.isNotEmpty) {
  //     return MyWallet.myWalletAddress;
  //   }
  //   String key = '${App.accountUuid}$address_key';
  //   MyWallet.myWalletAddress = await SingletonSecureStorage().read(key: key);
  //   return MyWallet.myWalletAddress;
  // }

  // //private_key
  // Future setPrivatekey(String private_key_local) async {
  //   MyWallet.wallet_private_key = private_key_local;
  //   await SingletonSecureStorage()
  //       .write(key: private_key, value: private_key_local);
  // }

  // Future<String> getPrivatekey() async {
  //   String key = '${App.accountUuid}$private_key';
  //   String? temp = await SingletonSecureStorage().read(key: key);
  //   temp ??= "";
  //   MyWallet.wallet_private_key = temp;
  //   return MyWallet.wallet_private_key;
  // }

  Future setPrivatekeyPart1(String value) async {
    await SingletonSecureStorage()
        .write(key: '${App.accountUuid}_private_key_part1', value: value);
  }

  Future<String> getPrivatekeyPart1() async {
    String key = '${App.accountUuid}_private_key_part1';
    String? temp = await SingletonSecureStorage().read(key: key);
    temp ??= "";
    return temp;
  }

  //seed_words
  Future setSeedWords(String seed_words) async {
    SingletonSecureStorage()
        .write(key: '${App.accountUuid}$seed_words_key', value: seed_words);
  }

  Future<String?> getSeedWords() async {
    String key = '${App.accountUuid}$seed_words_key';
    return SingletonSecureStorage().read(key: key);
  }

  //user_profile_api_data
  Future setUserProfileApiData(String value) async {
    // SingletonSecureStorage().write(key: 'user_profile_api_data', value: value);
  }

  // todo need to use this to cache data
  Future<dynamic> getUserProfileApiData() async {
    String key = 'user_profile_api_data';
    String result = await SingletonSecureStorage().read(key: key);
    if (result.isNotEmpty) {
      try {
        return jsonDecode(result);
      } catch (e) {}
    }
    return {};
  }

  //seed_words
  Future setIsNotificationPermissionAsked(String value) async {
    SingletonSecureStorage()
        .write(key: 'notificationPermissionOnHomePage', value: value);
  }

  Future<bool> getIsNotificationPermissionAsked() async {
    String key = 'notificationPermissionOnHomePage';
    String? result = await SingletonSecureStorage().read(key: key);
    result ??= "";
    return result.isNotEmpty;
  }

  //wpe
  Future set_energy_refill_amount(String energy_refill_amountlocal) async {
    SingletonSecureStorage()
        .write(key: energy_refill_amount, value: energy_refill_amountlocal);
  }

  Future<String?> get_energy_refill_amount() async {
    return SingletonSecureStorage().read(key: energy_refill_amount);
  }

  //Is Wallet Loaded
//   bool isWalletLoaded() {
// /*    if (getAddress() == "" || getAddress() == null) {
//       return false;
//     }
//
//     if (getPrivatekey() == "" || getPrivatekey() == null) {
//       return false;
//     }*/
//
// //        String connected_wallet = App.prefs.getString("connected_wallet", "");
// //        if (!connected_wallet.isEmpty()) {
// //            if (!prefs.getString("address", "").equalsIgnoreCase(connected_wallet)) {
// //                System.out.println("address not found1");
// //                return false;
// //            }
// //        }
// //     return true;
//   }

  //////////////////////////////////////////////////

  void clearRefreshToken() {
    SingletonSecureStorage().write(key: refresh_token_key, value: "");
    // final storage = new FlutterSecureStorage();
    // IOSOptions _getIOSOptions() => IOSOptions(
    //   accountName: _getAccountName(),
    // );
    // AndroidOptions _getAndroidOptions() => const AndroidOptions(
    //   encryptedSharedPreferences: true,
    // );
    //
    // // Write value
    // await storage.write(
    //     key: '$selectedsName', value: s_name);
    //
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('${refresh_token}', "");
  }

  Future logout() async {
    // SingletonSecureStorage().deleteAll();
    // reset user details on logout from suprsend
    // suprsend.user.unSet(["iospush", "androidpush"]);
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (Platform.isAndroid) {
        // suprsend.unSetAndroidFcmPush(token!);
        await Future.delayed(Duration(milliseconds: 200));
      }
      FirebaseMessaging.instance.deleteToken();
    } catch (e) {}
    App.firstName = "";
    App.referralLink = "";
    // MyWallet.myWalletAddress = '';
    // if (App.playerData != null) {
    //   App.playerData.clubShare = "";
    //   App.playerData.summaryShare = "";
    //   App.playerData.analyticsShare = "";
    //   App.playerData.categoryUpShare = "";
    //   App.playerData.leaderboardShare = "";
    //   App.playerData.onboardingInvite = "";
    // }

    // App.avatarAssets = [];
    App.friendsList.value = [];
    // App.activityList.value = [];
    App.activityNotificationList.value = [];
    // App.activityList.value = [];
    App.setAvatarUserConfigScript('');
    App.setAvatarFullConfigScript('');
    // suprsend.flush();
    // suprsend.reset();
    SingletonSecureStorage().write(key: access_token_key, value: "");
    SingletonSecureStorage().write(key: first_name_key, value: "");
    SingletonSecureStorage().write(key: "user_profile_api_data", value: "");

    // SingletonSecureStorage().write(key: '$address_key', value: "");
    // SingletonSecureStorage().write(key: '$private_key', value: "");
    // SingletonSecureStorage().write(key: '$seed_words_key', value: "");
    // SingletonSecureStorage().write(key: '$secure_pin_key', value: "");
  }

  void clearAcessToken() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('${access_token}', "");
    SingletonSecureStorage().write(key: access_token_key, value: "");
  }

  Future setPreferenceSplash(bool value) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool('${splashShow}', value);
    SingletonSecureStorage().write(key: splashShow, value: "");
  }

  Future<String?> getPreferenceSplash() async {
    // final prefs = await SharedPreferences.getInstance();
    // bool? key = prefs.getBool('${splashShow}');
    // return key;
    return SingletonSecureStorage().read(key: splashShow);
  }

/*  Future setTokenPreference({
    required String accesstoken,
    required String refreshtoken,
  }) async {
    // final prefs = await SharedPreferences.getInstance();
    String access = base64.encode(accesstoken.codeUnits);
    String refresh = base64.encode(refreshtoken.codeUnits);

    SingletonSecureStorage().write(key: '$access_token_key', value: access);
    SingletonSecureStorage().write(key: '$access_token_key', value: refresh);

    // prefs.setString('${access_token}', access);
    // prefs.setString('${refresh_token}', refresh);
    // prefs.setString('${atTimeStamp}', getTimeStampNow());
  }*/

  //last_level
  Future setLastLevel(String value) async {
    SingletonSecureStorage().write(key: last_level, value: value);
  }

  Future<String> getlastLevel() async {
    return SingletonSecureStorage().read(key: last_level);
  }

  Future setLatestVersion(String value) async {
    SingletonSecureStorage().write(key: 'latest_app_version', value: value);
  }

  Future<int> getLatestVersion() async {
    try {
      String value =
      await SingletonSecureStorage().read(key: 'latest_app_version');
      return int.parse(value);
    } catch (e) {}
    return 0;
  }

  Future setForceVersion(String value) async {
    SingletonSecureStorage().write(key: 'force_app_version', value: value);
  }

  Future<int> getForceVersion() async {
    try {
      String value =
      await SingletonSecureStorage().read(key: 'force_app_version');
      return int.parse(value);
    } catch (e) {}
    return 0;
  }

  Future setHeight(String value) async {
    SingletonSecureStorage().write(key: height, value: value);
  }

  Future<String> getHeight() async {
    return SingletonSecureStorage().read(key: height);
  }

  Future setWeight(String value) async {
    SingletonSecureStorage().write(key: weight, value: value);
  }

  Future<String> getWeight() async {
    return SingletonSecureStorage().read(key: weight);
  }

  Future setFitEnabled(String value) async {
    SingletonSecureStorage().write(key: fit_enabled, value: value);
  }

  Future<String> getFitEnabled() async {
    return SingletonSecureStorage().read(key: fit_enabled);
  }

  Future setRefreshTokenOld(String refresh) async {
    // final prefs = await SharedPreferences.getInstance();
    // String refresh = base64.encode(refreshtoken.codeUnits);
    // prefs.setString('${refresh_token_old}', refresh);
    SingletonSecureStorage().write(key: refresh_token_old, value: refresh);
  }

  Future<String> getRefreshTokenOld() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? key = prefs.getString('${refresh_token_old}');
    // Uint8List access = base64.decode(key == null ? "" : key);
    // return String.fromCharCodes(access);

    return SingletonSecureStorage().read(key: refresh_token_old);
  }

  Future<String?> getIsUsernameLogin() async {
    // final prefs = await SharedPreferences.getInstance();
    // bool? key = prefs.getBool('${isUsernameLogin}');
    // return key;

    return SingletonSecureStorage().read(key: is_username_login);
  }

  Future setIsUsernameLogin({required String val}) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool('$isUsernameLogin', val);
    SingletonSecureStorage().write(key: is_username_login, value: val);
  }

  // Future<String> getRefreshToken() async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   // String? key = prefs.getString('${refresh_token}');
  //   // Uint8List refresh = base64.decode(key == null ? "" : key);
  //   // return String.fromCharCodes(refresh);
  //   return SingletonSecureStorage().read(key: '${refresh_token}');
  // }

  Future clearPreferenceData() async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    return SingletonSecureStorage().deleteAll();
  }

  Future clearPreferenceDataAndGetOff() async {
    SingletonSecureStorage().deleteAll();

    Get.offAllNamed(Routes.splashPage);
    //Get.offAllNamed(Routes.splashPage);
  }

  Future setHideIncreasedWardrobeCapacityNudge(bool value) async {
    SingletonSecureStorage()
        .write(key: increased_wardrobe_capacity, value: '$value');
  }

  Future getHideIncreasedWardrobeCapacityNudge() async {
    var returnRes = false;
    var result =
    await SingletonSecureStorage().read(key: increased_wardrobe_capacity);
    if (result != null && result == "true") {
      returnRes = true;
    }
    return returnRes;
  }

  Future setHideMaxWardrobeCapacityNudge(bool value) async {
    SingletonSecureStorage().write(key: max_wardrobe_capacity, value: '$value');
  }

  Future getHideMaxWardrobeCapacityNudge() async {
    var returnRes = false;
    var result =
    await SingletonSecureStorage().read(key: max_wardrobe_capacity);
    if (result == "true") {
      returnRes = true;
    }
    return returnRes;
  }

  Future setReferralCapacity(bool value) async {
    SingletonSecureStorage()
        .write(key: setReferralCapacityKey, value: '$value');
  }

  Future getReferralCapacity(bool referralSlotsFlag) async {
    var returnRes = false;
    var result =
    await SingletonSecureStorage().read(key: '$setReferralCapacity');
    if (result == "true") {
      returnRes = true;
    }
    return returnRes;
  }

//   public static String get_signed_message(String message) throws CipherException, IOException {
//   Credentials credentials  = Credentials.create(App.getPrivateKey());
//   Sign.SignatureData signature = Sign.signPrefixedMessage(message.getBytes(StandardCharsets.UTF_8), credentials.getEcKeyPair());
//   String r = Numeric.toHexStringNoPrefix(signature.getR()).replaceFirst("0x", "");
//   String s = Numeric.toHexStringNoPrefix(signature.getS()).replaceFirst("0x", "");
//   String v = Numeric.toHexStringNoPrefix(signature.getV()).replaceFirst("0x", "");
//   String sm = "0x" + r + s + v;
//   return sm;
// }

  // static Future<String> get_signed_message_with_private_key(
  //     String message, String private_key) async {
  //   final creds = EthPrivateKey.fromHex(private_key);
  //   await creds.extractAddress().then((value) {
  //     // if (kDebugMode) print("Address:");
  //     // if (kDebugMode) print(value);
  //   });
  //
  //   final hash = Uint8List.fromList(utf8.encode(message));
  //   final signature = await creds.signPersonalMessage(hash);
  //
  //   String r =
  //   bytesToHex(signature.getRange(0, 32).toList()).replaceFirst("0x", "");
  //   String s =
  //   bytesToHex(signature.getRange(32, 64).toList()).replaceFirst("0x", "");
  //   String v =
  //   bytesToHex(signature.getRange(64, 65).toList()).replaceFirst("0x", "");
  //   String sm = "0x$r$s$v";
  //   return sm;
  //   // return signature;
  // }

  // static encryptAES(plainText, String timestamp) {
  //   String tempuid= App.accountUuid.replaceAll("-", '');
  //   String password =
  //       "${tempuid.substring(0,tempuid.length - timestamp.length)}${timestamp}";
  //   print("password: ${password}, len: ${password.length}");
  //   final enc.Key key = enc.Key.fromUtf8(password);
  //   final iv = enc.IV.fromLength(16);
  //   final encrypter = enc.Encrypter(enc.AES(key,mode: enc.AESMode.cbc));
  //   enc.Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
  //   print("=========");
  //   print(encrypted.base64);
  //   print('iv: ${iv.base64}');
  //   print("=========");
  // }

  String decrypt(String encryptedString, String timestamp) {
    String tempuid = App.accountUuid.replaceAll("-", '');
    String password =
        "${tempuid.substring(0, tempuid.length - timestamp.length)}${timestamp}";

    // Decode the base64 input to get the JSON string
    final jsonString = utf8.decode(base64.decode(encryptedString));
    final jsonData = jsonDecode(jsonString);

    final encryptedValue = jsonData["value"];
    final ivString = jsonData["iv"];
    final mac = jsonData["mac"];
    final enc.IV iv = enc.IV.fromBase64(ivString);

    // Verify the MAC
    final enc.Key key = enc.Key.fromUtf8(password);
    crypto.Hmac hmacSha256 = crypto.Hmac(crypto.sha256, key.bytes);
    crypto.Digest sha256Result =
    hmacSha256.convert(utf8.encode(ivString + encryptedValue));

    if (sha256Result.toString() != mac) {
      throw Exception("Data has been tampered with!");
    }

    // Decrypt the data
    final enc.Encrypter encrypter =
    enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: null));
    final decryptedBytes = encrypter.decrypt64(encryptedValue, iv: iv);

    final unpaddedBytes =
    unpad(Uint8List.fromList(utf8.encode(decryptedBytes)));
    final decodedString = utf8.decode(unpaddedBytes);

    return decodedString.trim();
  }

  List<int> unpad(Uint8List data) {
    int i = data.length - 1;
    while (data[i] == 0) {
      i--;
    }
    return data.sublist(0, i + 1);
  }

  String encrypt(String string, String timestamp) {
    String tempuid = App.accountUuid.replaceAll("-", '');
    String password =
        "${tempuid.substring(0, tempuid.length - timestamp.length)}${timestamp}";
    // print("password: ${password}, len: ${password.length}");
    int IV_LENGTH = 16;
    final enc.Key key = enc.Key.fromUtf8(password); // Valid AES key
    final enc.IV iv = enc.IV.fromSecureRandom(IV_LENGTH); // IV_LENGTH = 16

    final dataPadded = pad(Uint8List.fromList(utf8.encode(string)), 256);
    final enc.Encrypter encrypter =
    enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: null));
    final encryptedJson = encrypter.encryptBytes(dataPadded, iv: iv);
    crypto.Hmac hmacSha256 = crypto.Hmac(crypto.sha256, key.bytes);
    crypto.Digest sha256Result =
    hmacSha256.convert(utf8.encode(iv.base64 + encryptedJson.base64));
    final encryptedText = "{\"value\":\"" +
        encryptedJson.base64 +
        "\",\"iv\":\"" +
        iv.base64 +
        "\",\"timestamp\":\"" +
        timestamp +
        "\",\"mac\":\"" +
        sha256Result.toString() +
        "\"}";
    var res = base64.encode(utf8.encode(encryptedText));
    return res;
  }

  String encrypt_with_password(String string, String password) {
    int IV_LENGTH = 16;
    final enc.Key key = enc.Key.fromUtf8(password); // Valid AES key
    final enc.IV iv = enc.IV.fromSecureRandom(IV_LENGTH); // IV_LENGTH = 16

    final dataPadded = pad(Uint8List.fromList(utf8.encode(string)), 256);
    final enc.Encrypter encrypter =
    enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: null));
    final encryptedJson = encrypter.encryptBytes(dataPadded, iv: iv);
    crypto.Hmac hmacSha256 = crypto.Hmac(crypto.sha256, key.bytes);
    crypto.Digest sha256Result =
    hmacSha256.convert(utf8.encode(iv.base64 + encryptedJson.base64));
    final encryptedText = "{\"value\":\"" +
        encryptedJson.base64 +
        "\",\"iv\":\"" +
        iv.base64 +
        "\",\"mac\":\"" +
        sha256Result.toString() +
        "\"}";
    var res = base64.encode(utf8.encode(encryptedText));
    return res;
  }

  Uint8List pad(Uint8List plaintext, int blockSize) {
    int padLength =
        (blockSize - (plaintext.lengthInBytes % blockSize)) % blockSize;
    if (padLength != 0) {
      BytesBuilder bb = BytesBuilder();
      Uint8List padding = Uint8List(padLength);
      bb.add(plaintext);
      bb.add(padding);
      return bb.toBytes();
    } else {
      return plaintext;
    }
  }

/*  static Future<String> get_signed_message(String message) async {
    String? privateKey = await StringHelper().getPrivatekey();
    final creds = EthPrivateKey.fromHex(privateKey!);
    // await creds.extractAddress().then((value){
    //   print("====================================");
    //   print("Address:");
    //   print(value);
    //   print("====================================");
    // });

    final hash = Uint8List.fromList(utf8.encode(message));
    final signature = await creds.signPersonalMessage(hash);

    String r =
    bytesToHex(signature.getRange(0, 32).toList()).replaceFirst("0x", "");
    String s =
    bytesToHex(signature.getRange(32, 64).toList()).replaceFirst("0x", "");
    String v =
    bytesToHex(signature.getRange(64, 65).toList()).replaceFirst("0x", "");
    String sm = "0x$r$s$v";
    return sm;
    // return signature;
  }*/

  static getNotoSansText(String message,
      {Color? color,
        FontWeight? font,
        TextAlign? alignment,
        double? fontSize,
        int? maxLines}) {
    return Text(
      message,
      overflow: TextOverflow.ellipsis,
      textAlign: alignment,
      maxLines: maxLines == null ? 1 : maxLines,
      softWrap: true,
      style: TextStyle(
        fontFamily: "Roboto",
        color: color == null ? White : color,
        fontSize: fontSize == null ? 15 : fontSize,
        fontWeight: font == null ? FontWeight.normal : font,
      ),
    );
  }

  getTimeStampNow() {
    return DateTime.now();
  }

  static String getTimeStamp() {
    // DateTime dateTime = DateTime.now().toUtc();
    // String ts = dateTime.toString();
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static int getTimeStampAsInt() {
    // DateTime dateTime = DateTime.now().toUtc();
    // String ts = dateTime.toString();
    return DateTime.now().millisecondsSinceEpoch;
  }

  String getTimeAMPM(String time) {
    // print('time $time');
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(3, 5));
    TimeOfDay time1 = TimeOfDay(hour: hour, minute: minute);
    String hour1 = "";
    if (time1.hourOfPeriod.toString().length == 1) {
      hour1 = "0${time1.hourOfPeriod.toString()}";
    } else {
      hour1 = time1.hourOfPeriod.toString();
    }
    String minute1 = "";
    if (time1.minute.toString().length == 1) {
      minute1 = "0${time1.minute.toString()}";
    } else {
      minute1 = time1.minute.toString();
    }
    String data =
        "${hour1}:${minute1}:${time1.period.toString().contains('am') ? 'AM' : 'PM'}";
    return data;
  }

  String getDateTimeAMPM(String time) {
    int hour = int.parse(time.substring(11, 13));
    int minute = int.parse(time.substring(14, 16));
    TimeOfDay time1 = TimeOfDay(hour: hour, minute: minute);
    String hour1 = "";
    if (time1.hourOfPeriod.toString().length == 1) {
      hour1 = "0${time1.hourOfPeriod.toString()}";
    } else {
      hour1 = time1.hourOfPeriod.toString();
    }
    String minute1 = "";
    if (time1.minute.toString().length == 1) {
      minute1 = "0${time1.minute.toString()}";
    } else {
      minute1 = time1.minute.toString();
    }
    String data =
        "$hour1:$minute1:${time1.period.toString().contains('am') ? 'AM' : 'PM'}";
    return time.substring(0, 11) + data;
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (App.currentVersion.isNotEmpty) {
      return "Version ${App.currentVersion}";
    }
    App.currentVersion = packageInfo.version;
    return "Version ${packageInfo.version}";
  }

  Future<String> getAppBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
    return packageInfo.buildNumber;
  }

///////////////////////////////////////////////////////////////

/*  //REMOVED_MG_PROMO_BOTTOM_SHEET
  is_shown_promo_mint_key
  Future setIs_shown_promo_mint(String value) async {
    SingletonSecureStorage()
        .write(key: '$is_shown_promo_mint_key', value: value);
  }

  Future<String?> getIs_shown_promo_mint() async {
    return SingletonSecureStorage().read(key: '$is_shown_promo_mint_key');
  }

  //is_shown_promo_mint_key
  Future setIs_shown_promo_mint_auto(String value) async {
    SingletonSecureStorage()
        .write(key: '$is_shown_promo_mint_key_auto', value: value);
  }

  Future<String?> getIs_shown_promo_mint_auto() async {
    return SingletonSecureStorage().read(key: '$is_shown_promo_mint_key_auto');
  }
  */

/* Future setsName({required String s_name}) async {
    final storage = new FlutterSecureStorage();

    // IOSOptions _getIOSOptions() => IOSOptions(
    //   accountName: _getAccountName(),
    // );
    //
    // AndroidOptions _getAndroidOptions() => const AndroidOptions(
    //   encryptedSharedPreferences: true,
    // );

    // Write value
    await storage.write(
        key: '$selectedsName', value: s_name);

    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('$selectedsName', s_name);
  }

  Future<String?> getsName() async {
    final prefs = await SharedPreferences.getInstance();
    String? key = prefs.getString('${selectedsName}');
    return key;
  }
  Future setAtTimeStamp(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('${atTimeStamp}', value);
  }

  Future<String> getAtTimeStamp() async {
    final prefs = await SharedPreferences.getInstance();
    String? key = prefs.getString('${atTimeStamp}');
    return (key == null ? "" : key);
  }
*/
}

class SingletonSecureStorage {
  static final SingletonSecureStorage _singleton =
  SingletonSecureStorage._internal();
  var storage;

  factory SingletonSecureStorage() {
    return _singleton;
  }

  getInstance() {
    if (_singleton != null) return _singleton;
  }

  init() {
    // Create storage
    storage = new FlutterSecureStorage();
  }

  Future write({required String key, required String value}) async {
    if (storage == null) init();
    // Todo : Only These will be added with uuid key
    //  static String address_key = "address";
    //   static String private_key = "private_key";
    //   static String public_key = "public_key";
    //   static String seed_words_key = "seed_words_key";
    //   static String secure_pin_key = "secure_pin_key";
    if (key == "address" ||
        key == "private_key" ||
        key == "public_key" ||
        key == "seed_words_key" ||
        key == "secure_pin_key") {
      String? account_uuid = await StringHelper().getAccountUuid();

      if (account_uuid == null) account_uuid = "";
      if (account_uuid.isEmpty) account_uuid = "";

      key = account_uuid + "" + key;
    }

    String baseValue = base64.encode(value.codeUnits);
    // write value
    await storage.write(key: key, value: baseValue);
  }

  Future<String> read({required String key}) async {
    if (storage == null) init();
    // String? key = prefs.getString('${access_token}');
    // Read value

    String? value = await storage.read(key: key);
    Uint8List decodeValue = base64.decode(value == null ? "" : value);
    return String.fromCharCodes(decodeValue);
  }

  Future delete({required String key}) async {
    if (storage == null) init();
    // Delete value
    await storage.delete(key: key);
  }

  Future deleteAll() async {
    if (storage == null) init();
    // Delete value
    await storage.deleteAll();
  }

  Future<Map<String, String>> readAll() async {
    if (storage == null) init();
    // Read all value
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }

  SingletonSecureStorage._internal();
}

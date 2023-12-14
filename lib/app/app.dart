// ignore_for_file: non_constant_identifier_names

library fitmint_flutter.globalsigleton;

import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/http_service.dart';
import 'network/http_service_impl.dart';



class App {
  //Location Local
  static bool showConfettiOnHome = false;
  static RxBool internetNotAvail = false.obs;

  //static Stream<bool> internetNotAvailStream = App.internetNotAvail.stream;
  static List<String> freezedDate = [];

  //user data
  static int id = 0;
  static int unFriendedPlayerId = 0;
  // static List<Announcement> announcements = [];
  // static List<AvatarAsset> avatarAssets = [];
  // static List<MysteryBox> mysteryBoxes = [];
  static RxBool showMysteryBoxesLottie = false.obs;
  // static List<ChallengesWorkout> challengeRewardData = [];
  static RxBool eligibleForReward = false.obs;
  static List summaryData = [];
  static List summaryOrder = [];
  static String workoutSummaryTagLine = "Your thursday afternoon activity";
  static RxList friendRequestsList = [].obs;
  static RxList<dynamic> clubPendingRequestItems = [].obs;

  // static String modelSourcePath = "";
  static String onboarding_variant = "";
  static dynamic singleFriend = null;
  static late SharedPreferences prefs;

  //is_active
  static bool club_visible = false;
  static bool avatarCreated = false;
  static bool avatarImageUpdated = false;
  static int avatarGender = 2;
  static String utmSource = "";
  static String utmCampaign = "";
  static String referredByCode = "";
  static String utmMedium = "";
  static String invitedClubUuidFromLink = "";
  static String invitedFriendUuidFromLink = "";

  static String firstName = "";
  static String userName = "";
  static String categoryName = "";
  static String email = "";
  static bool suprsendIdentityDone = false;
  static int avatarId = 0;
  static int clubsCount = 0;
  static String avatarFullImage = "";
  static String avatarHomePageImage = "";
  static String avatarFullLeftPoseImage = "";
  static String avatarFullRightPoseImage = "";
  static String temp_username = "";
  static Future<void> hapticFeedback = HapticFeedback.mediumImpact();
  static Duration rippleAnimationDuration = const Duration(milliseconds: 100);
  static bool weeklyRecapNudge = false;
  static bool monthlyRecapNudge = false;
  static bool wonInPastWeek = false;
  static String wonInPastWeekDates = "";
  static bool wonInPastWeekSeen = false;
  static int wardrobeCapacity = 12;
  static bool has_friend = false;
  static int counterValueCam = 1;
  static RxBool firstTimeCameraNuge = false.obs;
  static RxBool firstTimeBubble = false.obs;
  static RxBool firstTimeBubbleEnable = true.obs;

  static List<String> listSelectedImages = [];

  // static String profileWeight = "";
  // static String profileHeight = "";
  static int profileGender = 0;
  static num defaultWeight = 0.0;
  static num defaultHeight = 0.0;

  static String profileDob = "";
  static String profileImage = "";
  static Map imageData = {};
  // static AudioSession? audioSession = null;

  static String referralLink = "";

  static String referred_by_firstname = "";
  static String referred_by_avatar = "";
  static int total_referrals = 0;
  static String referral_my_code = "";
  static bool referralSlotsFlag = false;
  static int referralSlots = 0;
  static bool originPassSlots = false;
  static RxBool challengesNotificationsSeen = false.obs;
  static List defaultMaleVibeList = [];
  static List avatarFaceConfigList = [];
  static List defaultFemaleVibeList = [];

  // static PlayerData playerData = playerDataFromJson();
  // static late PlayerData playerData;

  static final App _singleton = App._internal();
  static late FirebaseAnalytics analytics;
  static String buildNumber = "";
  static String version = "";
  static String deviceVersion = "";
  static String deviceManufacturer = "";

  // static String BASE_URL = "https://api-qa.fitsetgo.io/api/";

  // static String BASE_URL = "https://api.fitsetgo.io/api/";
  static String BASE_URL = "https://oracle.fitx.tech/api/";

  static RxInt total_active_minutes_today = 0.obs;
  static RxInt covered_active_minutes = 0.obs;
  static RxInt percentage = 0.obs;

  static bool workoutMinDistanceWarningShown = false;

  static String audioCueUuid = '';

  //TODO: For prod change the URL
  // static String BASE_URL = "https://api-qa1.fitsetgo.io/api/";
  //
  // static RxString getCategory() {
  //   return App.playerData.category.obs;
  // }

  static int getGoalWidgetPercentage() {
    if (App.covered_active_minutes.value == 0) return 0;
    if (App.total_active_minutes_today.value == 0) return 0;

    return ((App.covered_active_minutes.value /
        App.total_active_minutes_today.value) *
        100)
        .toInt();
  }

  static String faqHtmlStr = '';

  static bool referralPageisOpen = false;

  // static dynamic homeWidget;

  // static RxInt levelCatledUp = 0.obs;
  // static RxInt levelCatledDown = 0.obs;
  // static RxInt oldLevel = 0.obs;
  // static RxString oldCat = "".obs;

  static int levelCatledDown = 0;
  static int levelCatledUp = 0;
  static int oldLevel = 0;
  static String oldCat = "";
  static String devSettingsPwd = "";
  static bool isLevelledUp = false;
  static bool isTodayFreezed = true;

  static dynamic otpCountDown = null;

  // static RxString modelSourcePath = "".obs;

  static String dynamicLinkPath = "";
  static String referralClubInviteLink = "";

  // static getHomeWidget() {
  //   homeWidget ??= HomeNewPage();
  //   return homeWidget;
  // }

  static dynamic ipData = {};

  factory App() {
    return _singleton;
  }

  App._internal();

  //Member variables
  static String regId = "";

  static String accessToken = "";
  static String accountUuid = "";
  static bool newUserBool = false;
  static bool fromNotifcaiton = false;
  static HttpService _httpService = HttpServiceImpl();
  static late BuildContext buildContext;

  static HttpService get httpService => _httpService;

  static String currentVersion = "";

  static String warning = "";

  static dynamic lastWorkoutHistory;
  static var mintedNewSneaker;
  static dynamic marketSneaker;
  static dynamic sneakerIntensityStatsConfig;

  static bool maintenance_running = false;

  //Needs SP for security EOF

  //Discord
  //#1
  static String discord_app_user_report_issue_link = "";

  //#2
  static String discord_app_user_general_link = "";

  //#3
  static String discord_report_issue_link = "";

  //#4
  static String discord_general_link = "";

  //#5
  static bool discord_app_user_role_granted = false;

  //#6
  static String discord_username = "";

  //#10
  static String inAppTitle = "";
  static String inAppDescription = "";
  static String inAppImageUrl = "";
  static String inAppLinkText = "";
  static String inAppLink = "";
  static bool apple_health_visible = false;

  // static GooglePlayServicesAvailability playStoreAvailability =
  //     GooglePlayServicesAvailability.unknown;

  //workout variables
  static RxList friendsList = [].obs;
  static List<String> friendsListIds = [];
  // static RxList<FriendActivity> activityList =
  //     [FriendActivity.fromJson({})].obs;
  static RxList activityNotificationList = [].obs;

  // static GeolocatorPlatform? geoLocatorPlatforml;
  static bool appInForeground = true;
  static bool pendingShowInactiveDialog = false;

  static bool isInternetAvailable = true;

  // total active distance which is visible to user in workout session
  static int _serverPort = 9898;

  static int get serverPort => _serverPort;
  static String _avatarUserConfigScript = '';
  static String _avatarFullConfigScript = '';

  static String get avatarUserConfigScript => _avatarUserConfigScript;

  static String get avatarFullConfigScript => _avatarFullConfigScript;

  static setAvatarUserConfigScript(String value) {
    // String scriptLocal = value.replaceAll(
    //     'this.bucket_url + "avatar-features/textures/"',
    //     '"http://127.0.0.1:${App.serverPort}/n_assets/avatar-features/textures/"');
    // scriptLocal = scriptLocal.replaceAll(
    //     "this.bucket_url + 'avatar-features/textures/",
    //     "'http://127.0.0.1:${App.serverPort}/n_assets/avatar-features/textures/");
    // // scriptLocal =
    // //     scriptLocal.replaceAll('colorImage.crossOrigin = "Anonymous";', '');
    // // scriptLocal =
    // //     scriptLocal.replaceAll('alphaImage.crossOrigin = "Anonymous";', '');
    // // scriptLocal =
    // // scriptLocal.replaceAll('this.updateEnvironment();', '');
    _avatarUserConfigScript = value;
  }

  static setAvatarFullConfigScript(String value) {
    _avatarFullConfigScript = value;
  }

  static setServerPort(int value) {
    _serverPort = value;
  }

  // static late Amplitude amplitude;
  static dynamic deepLink;
  static late Map gcd;
  static String country_image = "";
  static int friends_count = 0;
  static bool send_ip_data = false;

  static const String REFER_CHANNEL = "USER_CHANNEL";
  static const String REFER_CAMPAIGN = "USER_INVITE_FROM_APP";
  static String REFER_USER_NAME = "";
  static String REFER_CUSTOMER_ID = "";

  //deeplink value`
  static const String REFER_BASE_DEEP_LINK = "https://www.fitsetgo.io";
  static const String REFER_BRAND_DOMAIN = "fitsetgo.onelink.me";
  static const String REFER_IMAGE_URL = "";

  // static ModelViewer modelViewer = ModelViewer(src: "");
  // static WebView webViewAvatar = WebView(initialUrl: "");

  static String loginMtd = "email";

  // static void gotoMain(int delay) {
  //   //need 1300ms delay to capture level down animation value.
  //   Future.delayed(Duration(milliseconds: delay), () {
  //     Get.offAllNamed(Routes.mainPage);
  //   });
  // }

  static Future<void> httpServiceInit() async {
    App._httpService = HttpServiceImpl();
    await App._httpService.init();
    await App._httpService.initNoBase();
  }

  /*
    On-Boarding
   */
  static bool viewAmplitudeEvent = false;
  static bool viewAmplitudeEventProperties = false;
  static bool firstTimeUserLvlUp = false;
  static RxBool firstTimeUserWorkOut = false.obs;
  static RxBool showLvlUpIntroScreen = false.obs;

  static RxBool firstTimeUserHomePage = false.obs;

  // static RxBool firstTimeUserLvlUp = false.obs;
  static RxBool firstTimeUserLvlDown = false.obs;

  /*
    Shared Preference
   */
  static String spFirstTimeUserWorkOut = "firstTimeUserWorkout";
  static String spFirstTimeWorkoutCameraNuge = "spFirstTimeWorkoutCameraNuge";
  static String firstTimeChallengesOpen = "firstTimeChallengesOpen";
  static bool amplitudeHomeSent = false;
  static bool avatarModifed = false;
  static RxBool isFirstTimeChallenges = false.obs;

  static double getTruncatedDouble(double value) {
    if (value < 0.0) {
      return 0.0;
    }
    return (value * 100).truncateToDouble() / 100;
  }

  static toTitleCase(String value) {
    return "${value[0].toUpperCase()}${value.substring(1, value.length)}";
  }

  /*
   Challengers

   */

  static bool challengersVisitedFirstTimeForAppSession = false;
  static int challengersUserListCount = 0;
  //
  // static String challengersTermsConditionsLink =
  //     "https://fitsetgo.freshdesk.com/support/solutions/articles/89000016692-challenges-t-cs";
  // static String challengersAdditionalFittLink =
  //     "https://fitsetgo.freshdesk.com/support/solutions/articles/89000016695-how-are-additional-fitt-rewards-calculated-";
  // static String challengersHowItWorksLink =
  //     "https://fitsetgo.freshdesk.com/support/solutions/articles/89000016694-how-challenges-work-on-fitsetgo-";

  // static Future<String?> getDeviceId() async {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfoPlugin.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else if (Platform.isAndroid) {
  //     // String? advertisingId = await AdvertisingId.id(true);
  //     // if (kDebugMode) {
  //     //   print("DEVICE_ID: AdvertisingId: ${advertisingId}");
  //     // }
  //     advertisingId ??= "";
  //     return advertisingId;
  //   }
  //   return "";
  // }
}

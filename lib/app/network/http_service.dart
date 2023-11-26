import 'package:dio/dio.dart';

abstract class HttpService {
  Future<void> init();

  Future<void> initNoBase();

  Future<Response> getRequest(String url, {bool needWait = false});

  Future<Response> getRequestNoBase(String url, {dynamic headers});

  Future<Response> postRequest1(String url,
      {dynamic postData, dynamic headers, needWait = false});

  Future<Response> postRequestNoBase(String url,
      {dynamic postData, dynamic headers, needWait = false});

  Future<Response> putRequest(String url,
      {dynamic putData, dynamic headers, needWait = false});

  Future<Response> patchRequest(String url,
      {dynamic putData, dynamic headers, needWait = false});

  Future<Response> deleteRequest(String url, {bool needWait = false});

  Future<void> logOutRequest();

  Future<String?> onlyRefreshToken();

  Future<dynamic> createPendingInviteForClubOnServer();

  Future<String> uploadImagesOnServer(String imageFile_path, String source,
      String workout_uuid, dynamic tempHeaders);

  Future<Response> getUserProfile(String screenName,
      {bool needWait = false, String required_fields = ""});

  Future<dynamic> getUserAvatarConfig();

  Future<dynamic> syncUserAssets();

  Future<dynamic> getAnnouncements();

  Future<dynamic> seenAnnouncement(String uuid_value);

  Future<bool> getTodayFreezed();

  Future<void> postLevelUnFreezeToday();

  Future<dynamic> getMysteryBox();

  Future<void> setUserDataInApp(var response);

  Future<Response> get_global_config({bool needWait = false});

  Future<dynamic> fetch_balances_from_server(String network, bool withAddress);

  Future<dynamic> fetch_locked_balances_from_server();

  Future<bool> remind_friends_from_promo_fitt(List<int> friend_ids);

  Future<dynamic> sendOtpToEmail(data);

  Future<dynamic> getWorkoutObjectives();

  Future<void> getWalletImportQuestion();

  Future<void> sendAppleHealthDataToServer(dynamic post_data);

  Future<bool> getImportWalletData(String queryString);

  Future<bool> save_onchain_txn_data(Map<String, dynamic> data);
}

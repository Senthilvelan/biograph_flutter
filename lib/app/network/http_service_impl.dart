import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Directory, File, Platform, SocketException;

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:queue/queue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart' as lockSync;


import '../app.dart';
import '../utils/url_helper.dart';
import '../utils_res/snackbar_helper.dart';
import '../utils_res/string_helper.dart';
import 'http_service.dart';

class HttpServiceImpl implements HttpService {
  // Dio _dio;
  var _dio;
  var _dio_nobase;

  // final queue = Queue();
  // var lockRefresh = lockSync.Lock();

  // late HttpService App.httpService;

  //  dio instance to request token
  // var tokenDio = Dio();

  // HttpService(){
  //   _dio = Dio();
  //   // init();
  // }
  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      if (kDebugMode) print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  @override
  Future<Response> getRequest(String url, {bool needWait = false}) async {
    final queueGetReq =
        Queue(delay: const Duration(milliseconds: 300), parallel: 1);
    final result = await queueGetReq.add(() async {
      if (kDebugMode) print(url);
      Response response;
      dynamic headers = null;
      if (url.contains("fitsetgo.io/api/") ||
          url.contains("oracle.fitx.tech/api/")) {
        if (kDebugMode) {
          print(
              '_dio.options.headers["Authorization"] is null setting up : token: ${App.accessToken}');
        }

        if (App.accessToken.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer ${App.accessToken}';
          if (kDebugMode) {
            print(
                '_dio.options.headers["Authorization"] added ${App.accessToken}');
            print("New headers ${_dio.options.headers}");
          }
        }
      }
      if (kDebugMode) print(_dio.options.headers);
      try {
        response = await _dio.get(url);
      } on DioError catch (e) {
        // if (e.response != null) {
        //   // ErrorInterceptorHandler? handler;
        //   int responseCode = e.response!.statusCode!;
        //   var decodedData = jsonDecode(e.response.toString());
        //   if (responseCode == 401 || decodedData["error"] == "invalid_token") {
        //     // _dio.lock();
        //     // _dio.interceptors.responseLock.lock();
        //     // _dio.interceptors.errorLock.lock();
        //
        //     // onlyRefreshToken().whenComplete(() {
        //     //   _dio.unlock();
        //     //   _dio.interceptors.responseLock.unlock();
        //     //   _dio.interceptors.errorLock.unlock();
        //     // }).then((accessToken) {
        //     //   try {
        //     //     if (accessToken != null && accessToken.trim().length > 0) {
        //     //       var options = e.response!.requestOptions;
        //     //       // options.headers['access-token'] = accessToken;
        //     //       options.headers['Authorization'] = 'Bearer ' + accessToken;
        //     //
        //     //       response = _dio.get(url, options);
        //     //     }
        //     //   } on DioError catch (e) {
        //     //     throw Exception(e);
        //     //     //handle 401, if needs
        //     //   }
        //     // });
        //   } else {
        //     // throw Exception(e);
        //   }
        // } else {
        //   // throw Exception(e);
        // }
        // throw Exception(e);
        if (e.response != null) {
          response = e.response!;
          if (App.BASE_URL.contains("oracle.") ||
              App.BASE_URL.contains("api-qa")) {
            SnackBarHelper.errorSnackbar(
              msg: "ERROR",
              content: "Status Code ${response.statusCode.toString()}}",
            );
          }
        } else {
          response = Response(
              requestOptions: RequestOptions(
                path: url,
              ),
              statusCode: 503);
        }

        if (needWait) {
          await checkForInternet(getRequest(url));
          await waitForInternet();
        } else {
          // if (e.error.osError.errorCode == 7) {
          if (await getInternetConnectionStatus() == false) {
            SnackBarHelper.showNoInternet();
          }
        }
      }

      return response;
    });
    return result;
  }

  @override
  Future<Response> getRequestNoBase(String url, {dynamic headers}) async {
    final queue = Queue(delay: Duration(milliseconds: 50), parallel: 1);

    final result = await queue.add(() async {
      if (kDebugMode) print(url);
      Response response;

      try {
        if (_dio_nobase == null) {
          await initNoBase();
        }
        response =
            await _dio_nobase.get(url, options: Options(headers: headers));
      } on DioError catch (e) {
        return Response(
          requestOptions: RequestOptions(path: ""),
          statusCode: 501,
        );
      }
      return response;
    });
    return result;
  }

  @override
  Future<Response> postRequestNoBase(String url,
      {dynamic postData, dynamic headers, needWait = false}) async {
    final queue = Queue(delay: Duration(milliseconds: 50), parallel: 1);

    final result = await queue.add(() async {
      if (kDebugMode) print(_dio_nobase.options.headers);
      if (url.contains("api-qa")) {
        if (kDebugMode) print("QA-DEBUG: in post request $url");
      }
      await Future.delayed(Duration(milliseconds: 50));
      Response response;
      try {
        if (headers != null) {
          response = await _dio_nobase.post(url,
              data: postData, options: Options(headers: headers));
        } else {
          response = await _dio_nobase.post(url, data: postData);
        }
      } on DioError catch (e) {
        throw Exception(e);
      }

      return response;
    });
    return result;
  }

  @override
  Future<Response> postRequest1(String url,
      {dynamic postData, dynamic headers, needWait = false}) async {
    final queue = Queue(delay: Duration(milliseconds: 50), parallel: 1);

    final result = await queue.add(() async {
      if (kDebugMode) {
        print(_dio.options.headers);
        print("QA-DEBUG: in post request ${App.BASE_URL}$url");
        print(postData);
      }

      // await Future.delayed(Duration(milliseconds: 50));
      if (_dio.options.headers["Authorization"] == null) {
        if (kDebugMode) {
          print('_dio.options.headers["Authorization"] is null setting up');
        }
        if (App.accessToken.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer ${App.accessToken}';
          if (kDebugMode) {
            print(
                '_dio.options.headers["Authorization"] added ${App.accessToken}');
            print("New headers ${_dio.options.headers}");
          }
        }
      }
      Response response;
      try {
        if (headers != null) {
          response = await _dio.post(url,
              data: postData, options: Options(headers: headers));
        } else {
          response = await _dio.post(url, data: postData);
        }
      } on DioError catch (e) {
        if (e.type == DioErrorType.connectTimeout) {
          return Response(
              requestOptions: RequestOptions(
                path: url,
              ),
              statusCode: 5566);
        }
        if (e.type == DioErrorType.receiveTimeout) {
          return Response(
              requestOptions: RequestOptions(
                path: url,
              ),
              statusCode: 5566);
        }
        if (e.response != null) {
          int responseCode = e.response!.statusCode!;
          if (App.BASE_URL.contains("oracle.") ||
              App.BASE_URL.contains("api-qa")) {
            SnackBarHelper.errorSnackbar(
              msg: "ERROR - API STATUS CODE",
              content: "Url: $url\nStatus Code ${responseCode.toString()}",
            );
          }

          if (await getInternetConnectionStatus() == false) {
            SnackBarHelper.showNoInternet();
            return e.response;
          }

          return e.response;
        } else {
          if (e.response == null) {
            return Response(
                requestOptions: RequestOptions(
                  path: url,
                ),
                statusCode: 1503);
          }
          return e.response!;

          // throw Exception(e);
        }
        throw Exception(e);
      }

      return response;
    });
    return result!;
  }

  @override
  Future<Response> putRequest(String url,
      {dynamic putData, dynamic headers, needWait = false}) async {
    Response response;
    try {
      response = await _dio.put(url,
          data: putData, options: Options(headers: headers));
    } on DioError catch (e) {
      if (await getInternetConnectionStatus() == false) {
        SnackBarHelper.showNoInternet();
        return e.response!;
      } else {
        if (kDebugMode) {
          SnackBarHelper.showNoInternet(
              content: "Some thing went wrong, Please try again!");
        }
      }
      return e.response!;
    }

    return response;
  }

  @override
  Future<Response> patchRequest(String url,
      {dynamic putData, dynamic headers, needWait = false}) async {
    Response response;
    try {
      response = await _dio.request(url,
          data: putData, options: Options(method: 'patch', headers: headers));
      if (kDebugMode) print(response.data);
    } on DioError catch (e) {
      if (kDebugMode) print(e.response);
      if (kDebugMode) print(url);

      // if (App.internetNotAvail.value == true) {
      if (await getInternetConnectionStatus() == false) {
        SnackBarHelper.showNoInternet();
        return e.response!;
      } else {
        if (kDebugMode) {
          SnackBarHelper.showNoInternet(
              content: "Some thing went wrong, Please try again!");
        }
        return e.response!;
      }

      // throw Exception(e.message);
    }

    return response;
  }

  @override
  Future<Response> deleteRequest(String url, {bool needWait = false}) async {
    Response response;
    try {
      response = await _dio.delete(url);
    } on DioError catch (e) {
      if (await getInternetConnectionStatus() == false) {
        SnackBarHelper.showNoInternet();
        return e.response!;
      } else {
        if (kDebugMode) {
          SnackBarHelper.showNoInternet(
              content: "Some thing went wrong, Please try again!");
        }
        return e.response!;
      }
    }

    return response;
  }

  // List<String> pendingUrls = [];
  Future<void> checkForInternet(request) async {
    // if (App.internetNotAvail.value ) {
    if (await getInternetConnectionStatus() == false) {
      //StreamSubscription<bool> listener =
      // App.internetNotAvail.stream.listen((event) {
      InternetConnectionCheckerPlus().onStatusChange.listen((status) {
        print('InternetConnectionCheckerPlus event : ' + status.toString());

        // pendingUrls.add(url);
        // if (App.internetNotAvail.value == false) {
        //   for (int i = 0; i < pendingUrls.length; i++) {
        //     Future.delayed(Duration(milliseconds: 300), () {
        //       getRequest(pendingUrls[i]);
        //     });
        //   } //eof for
        //   pendingUrls.clear();
        // }

        if (status == true) {
          Future.delayed(Duration(milliseconds: 300), () async {
            request;
          });
          // getRequest(url);
        }
      });
    } else {
      Future.delayed(Duration(milliseconds: 300), () async {
        request;
      });
    }
  }

  Future<bool> waitForInternet() async {
    // while (App.internetNotAvail.value) {
    while (await getInternetConnectionStatus() == false) {
      await Future.delayed(
        const Duration(milliseconds: 1300),
      );
    }

    return true;
  }

  getInternetConnectionStatus() async {
    return await InternetConnectionCheckerPlus().hasConnection;
  }

  initializeInterceptors(var _dio) {
    //var lockInterceptors = lockSync.Lock(reentrant: true);

    // lockInterceptors.synchronized(() {
    // Only this block can run (once) until done

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (kDebugMode) {
        print("QA-DEBUG: BASE URL ${options.baseUrl}${options.path}");
      }

      var checking_ssl = true;

      await Future.delayed(Duration(milliseconds: 50));
      // print(checking_ssl);
      if (checking_ssl == true) {
        return handler.next(options); //continue
      } else {
        await StringHelper().clearPreferenceDataAndGetOff();
        SnackBarHelper.errorSnackbar(
            msg: "Error", content: "Please try again !");
        handler.reject(new DioError(requestOptions: options));
      }

      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      // print("response is " + response.data);
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioError err, ErrorInterceptorHandler handler) async {
      if (err.response?.statusCode == 401 &&
          err.response!.data['error'] == "invalid_token") {
        if (kDebugMode) {
          print("------------1. invalid token called -----------------");
        }

        //clear the access token
        // await StringHelper().clearAcessToken();
        await Future.delayed(Duration(milliseconds: 50));

        _dio.lock();
        _dio.interceptors.responseLock.lock();
        _dio.interceptors.errorLock.lock();

        onlyRefreshToken().whenComplete(() {
          _dio.unlock();
          _dio.interceptors.responseLock.unlock();
          _dio.interceptors.errorLock.unlock();
        }).then((accessToken) {
          if (accessToken != null && accessToken.trim().length > 0) {
            // Future.delayed(Duration(milliseconds: 50));

            var options = err.response!.requestOptions;
            options.headers['access-token'] = accessToken;
            options.headers['Authorization'] = 'Bearer ' + accessToken;

            _dio.fetch(options).then(
              // (r) => handler.resolve(r),
              (r) {
                handler.resolve(r);
              },
              onError: (e, handler) {
                handler.reject(e);
              },
            );
          }
        });
        return;
      }
      return handler.next(err); //continue
    }));
    //});
  }

  @override
  Future<void> initNoBase() async {
    var lockInit = lockSync.Lock();
    await lockInit.synchronized(() async {
      _dio_nobase = Dio(BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 40 * 1000, // 40 seconds
          receiveTimeout: 40 * 1000 // 40 seconds
          ));
      await Future.delayed(Duration(milliseconds: 50));
      initializeInterceptors(_dio_nobase);
    });
  }

  @override
  Future<void> init() async {
    var lockInit = lockSync.Lock();

    await lockInit.synchronized(() async {
      var headers = {'DeviceType': 'PWA'};
      var accessTokenInit;

      // If username and password given then update Auth with Basic Authentication and Headers
      if (App.accessToken!.isNotEmpty) {
        headers['Authorization'] = 'Bearer ' + App.accessToken;
        if (kDebugMode) {
          print("Access token set in init()");
        }
      }

      headers['X-BuildNumber'] = App.buildNumber;
      headers['X-BuildVersion'] = App.version;
      headers['X-deviceVersion'] = App.deviceVersion;
      headers['X-deviceManufacturer'] = App.deviceManufacturer;

      headers['X-Platform'] = "";
      if (Platform.isAndroid) {
        headers['X-Platform'] = "android";
      } else if (Platform.isIOS) {
        headers['X-Platform'] = "ios";
      } else {
        headers['X-Platform'] = Platform.operatingSystem;
      }
      // await StringHelper().getAddress().then((address) {
      //   if (address!.isNotEmpty) {
      //     headers['X-Address'] = address;
      //   } else {
      //     return;
      //   }
      // });

      //   if (accessTokenInit.isEmpty) return;

      //   if (accessTokenInit.toString().length <= 0) return;
      _dio = Dio(BaseOptions(
          baseUrl: App.BASE_URL,
          headers: headers,
          receiveDataWhenStatusError: true,
          connectTimeout: 40 * 1000,
          // 40 seconds
          receiveTimeout: 40 * 1000 // 40 seconds
          ));

      // headers: <String, String>{'authorization': Auth}

      // String PEM='XXXXX'; // certificate content
      // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
      //   client.badCertificateCallback=(X509Certificate cert, String host, int port){
      //     if(cert.pem==PEM){ // Verify the certificate
      //       print('certificate is valid');
      //       return true;
      //     }
      //     print('certificate is not valid');
      //     return true;
      //   };
      // };

      //Temp.Fix
      // await Future.delayed(Duration(milliseconds: 50));
      initializeInterceptors(_dio);
    });
    return;
  }

  // var lockRefresh;

  Future<String?> onlyRefreshToken() async {
    // Use this object to prevent concurrent access to data
    // if(lockRefresh == null){
    //   lockRefresh = lockSync.Lock();
    // }

    // await Future.delayed(Duration(milliseconds: 50));
    var lockRefresh = lockSync.Lock();

    String? result = await lockRefresh.synchronized(() async {
      //  final queue = Queue(delay: Duration(milliseconds: 300),parallel: 1);
      //  final result = await queue.add(() async {
      // Only this block can run (once) until done

      String resultString = '';

      try {
        bool isUpdated = false;

        String _rToken = '';
        String _rTokenOld = '';

        await StringHelper().getRefreshToken().then((_rTokenLoc) {
          if (_rTokenLoc!.isNotEmpty) {
            _rToken = _rTokenLoc;
          } else {
            return resultString;
          }
        });

        await StringHelper().getRefreshTokenOld().then((_rTokenOldLoc) {
          if (_rTokenOldLoc.isNotEmpty) {
            _rTokenOld = _rTokenOldLoc;
          } else {
            return resultString;
          }
        });

        await Future.delayed(Duration(milliseconds: 100));

        if (!(_rToken.compareTo(_rTokenOld) == 0)) {
          //_rTokenOld = _rToken;
          isUpdated = true;
          // StringHelper().getAtTimeStamp().then((storedDateTimeStr) {
          //   if (storedDateTimeStr.isNotEmpty) {
          //     var currentTime = DateTime.now();
          //     DateTime storedDateTimeOld = storedDateTimeStr as DateTime;
          //     Duration duration = currentTime.difference(storedDateTimeOld);
          //     if (duration.inDays > 0) {
          //       isUpdated = true;
          //     } else if (duration.inHours > 0) {
          //       isUpdated = true;
          //     } else if (duration.inMinutes > 5) {
          //       isUpdated = true;
          //     }
          //   } else {
          //     isUpdated = true;
          //   }
          // });
        } else {
          isUpdated = false;
          return resultString;
        }

        // if (!isUpdated) {
        //   return resultString;
        // }

        // Map<String, dynamic> refreshHeaders = {};
        // refreshHeaders = {"refresh-token": _rToken, 'DeviceType': 'PWA'};

        dynamic data = {};

        var tokenDio = Dio();

        StringHelper().setRefreshTokenOld(_rToken);

        // await tokenDio
        //     .post(BASE_URL + ACCESS_TOKEN_REFRESH_URL,data:data,
        //     options: Options(headers: refreshHeaders))

        await tokenDio
            .post(
          App.BASE_URL + ACCESS_TOKEN_REFRESH_URL,
          data: data,
        )
            .then((d) async {
          // await StringHelper().setTokenPreference(
          //     accesstoken: d.data['access_token'],
          //     refreshtoken: d.data['refresh_token']);
          // return 'Bearer ' + d.data['access_token'];
          // print(d.data['access_token']);
          if (kDebugMode) {
            print("======================Access token updated=============");
          }
          resultString = d.data['access_token'];
          return resultString;
        });
      } catch (err, st) {
        StringHelper().setRefreshTokenOld('');
        if (kDebugMode) print("Error in Access Token Update");
        return resultString;
      }
      return resultString;
    });

    return result;
  }

  @override
  Future<dynamic> sendOtpToEmail(data) async {
    if (data == null) return;

    try {
      return await postRequest1(GET_EMAIL_OTP, postData: data);
    } catch (e) {
      if (kDebugMode) print(e);
      return;
    }
  }

  @override
  Future<void> logOutRequest() {
    // TODO: implement logOutRequest
    throw UnimplementedError();
  }
//
//   @override
//   Future<Response> get_global_config({bool needWait = false}) async {
//     var response = await getRequest(GET_APP_CONFIG_URL, needWait: needWait);
//     if (kDebugMode) {
//       print(
//           'global config, code :  ${response.statusCode} ,response: ${response} ');
//     }
//
//     try {
//       if (response.statusCode == 401) return response;
//     } catch (err, st) {
//       if (kDebugMode) print(err);
//       return response;
//     }
//     if (kDebugMode) {
//       print(response.data);
//     }
//     if (response.statusCode == 200) {
//       if (response.data["data"] != null) {
//         var responseData = response.data["data"];
//
//         MyWallet.game_v1_address = responseData["game_v1_address"];
//         MyWallet.token_address = responseData["token_address"];
//         MyWallet.nft_address = responseData["nft_address"];
//         MyWallet.show_wallet = responseData["show_wallet"];
//
//         try {
//           if (responseData["club_visible"] != null) {
//             App.club_visible = responseData["club_visible"];
//           }
//         } catch (e) {}
//
//         if (responseData["dsp"] != null) {
//           App.devSettingsPwd = responseData["dsp"];
//         }
//         try {
//           if (responseData['is_under_maintenance'] != null) {
//             App.maintenance_running = responseData["is_under_maintenance"];
//           }
//           if (responseData['ios_force_app_version'] != null) {
//             if (Platform.isIOS) {
//               StringHelper()
//                   .setForceVersion("${responseData['ios_force_app_version']}");
//               StringHelper().setLatestVersion(
//                   "${responseData['ios_latest_app_version']}");
//             } else {
//               StringHelper().setForceVersion(
//                   "${responseData['android_force_app_version']}");
//               StringHelper().setLatestVersion(
//                   "${responseData['android_latest_app_version']}");
//             }
//           }
//         } catch (e) {}
//
//         if (responseData["refresh_ip_data"] != null) {
//           App.send_ip_data = responseData["refresh_ip_data"];
//         }
//         if (responseData["apple_health_visible"] != null) {
//           App.apple_health_visible = responseData["apple_health_visible"];
//         }
//         if (responseData["discord_link"] != null) {
//           App.discord_general_link = responseData["discord_link"];
//         }
//         MyWallet.minimum_fitt_withdrawl =
//             responseData["minimum_fitt_withdrawl"];
//         App.country_image = responseData["country_image"];
//         StringHelper().setWpe(responseData["wpe"]);
//         //#9
//         if (responseData["chain_id"] != null) {}
//         if (responseData["chain_id"] != null) {
//           MyWallet.chain_id = responseData["chain_id"];
//         }
//       }
//     }
//     return response;
//   }
//
//   @override
//   Future<dynamic> createPendingInviteForClubOnServer() async {
//     if (kDebugMode) {
//       print("createPendingInviteForClubOnServer called ");
//     }
//     if (App.invitedClubUuidFromLink.isEmpty) {
//       return null;
//     }
//     String ts = StringHelper.getTimeStamp();
//     dynamic jsonRequest = {
//       "invited_club_uuid": App.invitedClubUuidFromLink,
//     };
//     if (!App.BASE_URL.contains("api-qa")) {
//       var res1 = StringHelper().encrypt(jsonEncode(jsonRequest), ts);
//       jsonRequest = {'a': res1};
//     }
//     if (kDebugMode) {
//       print("Encrypted payload $jsonRequest");
//     }
//     var response = await postRequest1(
//         CREATE_PENDING_INVITE_FOR_CLUB.replaceAll(
//             "<club_uuid>", App.invitedClubUuidFromLink),
//         postData: jsonRequest);
//     try {
//       if (response.statusCode == 401) return response;
//     } catch (err, st) {
//       return response;
//     }
//     if (kDebugMode) {
//       print(response.data);
//     }
//
//     return response;
//   }
//
//   @override
//   Future<String> uploadImagesOnServer(String imageFile_path, String source,
//       String workout_uuid, dynamic tempHeaders) async {
//     dynamic headers = {};
//     String ts = StringHelper.getTimeStamp();
//     String fileName = imageFile_path.split('/').last;
//     dynamic postData = {"timestamp": ts, 'source': source};
//     if (workout_uuid.isNotEmpty) {
//       postData['workout_uuid'] = workout_uuid;
//     }
//     dynamic file =
//         await MultipartFile.fromFile(imageFile_path, filename: fileName);
//     FormData formData = FormData.fromMap({
//       'file': file,
//       "timestamp": ts,
//       'source': source,
//     });
//     if (workout_uuid.isNotEmpty) {
//       formData = FormData.fromMap({
//         'file': file,
//         "timestamp": ts,
//         'source': source,
//         'workout_uuid': workout_uuid
//       });
//     }
//
//     if (!App.BASE_URL.contains("api-qa")) {
//       var res1 = StringHelper().encrypt(jsonEncode(postData), ts);
//       postData = {'a': res1};
//       formData = FormData.fromMap({
//         'file': file,
//         'a': res1,
//         'source': source,
//         'workout_uuid': workout_uuid
//       });
//       if (kDebugMode) {
//         print("Encrypted payload $postData");
//       }
//     }
//
//     String url = UPLOAD_SUBMIT_BUG_FILE;
//
//     if (url.contains("api-qa")) {
//       if (kDebugMode) {
//         print(_dio.options.headers);
//         print("QA-DEBUG: in post request $url");
//         print(postData);
//       }
//     }
//
//     headers = _dio.options.headers;
//
//     Response response = Response(
//       requestOptions: RequestOptions(
//         path: url,
//       ),
//       statusCode: 400,
//     );
//     try {
//       response = await _dio.post(url,
//           data: formData, options: Options(headers: headers));
//     } on DioError catch (e) {
//       // e.printError();
//     }
//
//     if (kDebugMode) {
//       print(response.data);
//       print("response.statusCode: ${response.statusCode}");
//     }
//     if (response.data['data'] != null) {
//       if (response.data['data']['file_url'] != null) {
//         return response.data['data']['file_url'];
//       }
//     }
//     return "";
//   }
//
//   @override
//   Future<Response> getUserProfile(String screenName,
//       {bool needWait = false, String required_fields = ""}) async {
//     if (kDebugMode) {
//       print("getUserProfile called from $screenName");
//     }
//     if (Workout.workoutTimestamp != 0) {
//       return Response(
//         requestOptions: RequestOptions(path: ""),
//         statusCode: 501,
//       );
//     }
//
//     String url = GET_USER_PROFILE_URL;
//     if (required_fields.isNotEmpty) {
//       url = "$url?requested_fields=$required_fields";
//     }
//     var response = await getRequest(url, needWait: needWait);
//     try {
//       if (response.statusCode == 401) return response;
//     } catch (err, st) {
//       return response;
//     }
//     if (kDebugMode) {
//       print(response.data);
//     }
//     if (response.statusCode == 200) {
//       if (response.data["data"] != null) {
//         print(
//             "LOG - ${StringHelper.getTimeStampAsInt()}  getting user profile Done");
//         if (needWait) {
//           await setUserDataInApp(response.data['data']);
//         } else {
//           setUserDataInApp(response.data['data']);
//         }
//       } else {
//         return response;
//       }
//     } else {
//       return response;
//     }
//     return response;
//   }
//
//   Future<dynamic> getWorkoutObjectives() async {
//     var otpResponse = await getRequest(GET_WORKOUT_CONFIG);
//     if (kDebugMode) {
//       print(otpResponse.data);
//     }
//     if (otpResponse.statusCode == 200) {
//       List<WorkoutObjective> workoutConfigList = [];
//       for (int i = 0; i < otpResponse.data['data'].length; i++) {
//         WorkoutObjective obj =
//             WorkoutObjective.fromJson(otpResponse.data['data'][i], false);
//         if (obj.value > 0) {
//           workoutConfigList.add(obj);
//         }
//       }
//       Workout.workoutConfigList.value = workoutConfigList;
//       Workout.checkReceivedTrackerConfig(true);
//       Workout.checkForLevelUp(false);
//
//       if (kDebugMode) {
//         print(
//             "Workout.workoutConfigList: ${Workout.workoutConfigList.value.length}");
//       }
//       // workoutConfig = otp
//     }
//     //eof if...elseif..else
//   }
//
//   Future<dynamic> getMysteryBox() async {
//     var otpResponse = await getRequest(GET_MYSERYBOX);
//
//     // if (kDebugMode) print("GET_MYSERYBOX : ${otpResponse.toString()}");
//
//     if (otpResponse.statusCode == 200) {
//       List<MysteryBox> result = [];
//       for (int i = 0; i < otpResponse.data['data'].length; i++) {
//         bool is_expired = false;
//         try {
//           if (otpResponse.data['data'][i]["is_expired"] != null) {
//             is_expired = otpResponse.data['data'][i]["is_expired"];
//           }
//         } catch (e) {}
//
//         MysteryBox obj = MysteryBox.fromJson(otpResponse.data['data'][i]);
//         if (!is_expired) result.add(obj);
//       }
//
//       App.mysteryBoxes = result;
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       int? len = prefs.getInt('mysteryBoxLength');
//       int flag = 0;
//       if (len != null) {
//         print("enter $len & ${App.mysteryBoxes.length}");
//         flag = 0;
//         if (len < App.mysteryBoxes.length) {
//           print("enter1");
//           for (int i = 0; i < App.mysteryBoxes.length; i++) {
//             print("enter$i");
//             if (App.mysteryBoxes[i].source == 2 &&
//                     App.mysteryBoxes[i].state == 1 ||
//                 App.mysteryBoxes[i].state == 0) {
//               print("enter$flag");
//               flag++;
//             }
//           }
//           // if (flag > 0 && App.firstTimeUserHomePage.value != true) {
//           //   App.showMysteryBoxesLottie.value = true;
//           // }
//         }
//         prefs.setInt('mysteryBoxLength', result.length);
//       } else {
//         prefs.setInt('mysteryBoxLength', result.length);
//       }
//       // print(result.toString());
//
//       // if (kDebugMode) {
//       //   print("GET_MYSERYBOX len: ${App.mysteryBoxes.length}");
//       // }
//       // workoutConfig = otp
//     }
//     //eof if...elseif..else
//   }
//
//   @override
//   Future<dynamic> getUserAvatarConfig() async {
//     var otpResponse = await getRequest(GET_USER_AVATAR_CONFIG, needWait: true);
//     print("getUserAvatarConfig: ${otpResponse.statusCode}");
//     if (otpResponse.statusCode == 200) {
//       print(
//           "otpResponse.data['full_script']: len: ${otpResponse.data['full_script'].length}");
//       print(
//           "otpResponse.data['user_config_script']: len: ${otpResponse.data['user_config_script'].length}");
//       App.setAvatarFullConfigScript(otpResponse.data['full_script']);
//       App.setAvatarUserConfigScript(otpResponse.data['user_config_script']);
//       if (kDebugMode) {
//         print("App.avatarAssets: ${App.avatarAssets.length}");
//       }
//       // workoutConfig = otp
//     }
//     //eof if...elseif..else
//   }
//
//   @override
//   Future<dynamic> syncUserAssets() async {
//     var otpResponse = await getRequest(GET_USER_ASSETS, needWait: true);
//
//     if (otpResponse.statusCode == 200 && otpResponse.data['data'] != null) {
//       List<AvatarAsset> result = [];
//       String initAssetScript = '';
//       for (int i = 0; i < otpResponse.data['data'].length; i++) {
//         AvatarAsset obj = AvatarAsset.fromJson(otpResponse.data['data'][i]);
//         await obj.save();
//         if (obj.selected) {
//           initAssetScript = "$initAssetScript ${obj.js_script}";
//         }
//         result.add(obj);
//       }
//       App.avatarAssets = result;
//       if (kDebugMode) {
//         print("App.avatarAssets: ${App.avatarAssets.length}");
//       }
//       // log("assetsssList${App.avatarAssets.toString()}");
//       // workoutConfig = otp
//     }
//     //eof if...elseif..else
//   }
//
//   @override
//   Future<dynamic> getAnnouncements() async {
//     var otpResponse = await getRequest(GET_ANNOUNCEMENTS, needWait: true);
//
//     if (otpResponse.statusCode == 200 && otpResponse.data['data'] != null) {
//       List<Announcement> result = [];
//       for (int i = 0; i < otpResponse.data['data'].length; i++) {
//         Announcement obj = Announcement.fromJson(otpResponse.data['data'][i]);
//         result.add(obj);
//       }
//       App.announcements = result;
//       if (kDebugMode) {
//         print("App.announcements: ${App.announcements.length}");
//       }
//     }
//   }
//
//   @override
//   Future<dynamic> seenAnnouncement(String uuid_value) async {
//     dynamic jsonRequest = {
//       "uuid": uuid_value,
//     };
//     // setLoading(true);
//     if (!App.BASE_URL.contains("api-qa")) {
//       String ts = StringHelper.getTimeStamp();
//       jsonRequest = {"uuid": uuid_value, "timestamp": ts};
//       var res1 = StringHelper().encrypt(jsonEncode(jsonRequest), ts);
//       jsonRequest = {'a': res1};
//       if (kDebugMode) {
//         print("Encrypted payload $jsonRequest");
//       }
//     }
//     var otpResponse = await postRequest1(
//         SEEN_ANNOUNCEMENT.replaceAll("<uuid>", uuid_value),
//         postData: jsonRequest);
//   }
//
//   @override
//   Future<void> postLevelUnFreezeToday() async {
//     DateFormat formatterRegular = DateFormat('yyyy-MM-dd');
//     String today = formatterRegular.format(DateTime.now());
//     dynamic jsonRequest = {
//       "freeze_days": [today],
//       'freeze': false,
//     };
//     // setLoading(true);
//     if (!App.BASE_URL.contains("api-qa")) {
//       String ts = StringHelper.getTimeStamp();
//       jsonRequest = {
//         "freeze_days": [today],
//         'freeze': false,
//         "timestamp": ts
//       };
//       var res1 = StringHelper().encrypt(jsonEncode(jsonRequest), ts);
//       jsonRequest = {'a': res1};
//       if (kDebugMode) {
//         print("Encrypted payload $jsonRequest");
//       }
//     }
//     try {
//       AmplitudeAnalysis.logEvent20("Unfreezed Before Workout",
//           eventProperties: {});
//     } catch (e) {
//       print(e.toString());
//     }
//
//     var response = await App.httpService
//         .postRequest1(GET_POST_LVL_FREEZE, postData: jsonRequest);
//
//     if (response.statusCode == 200) {}
//   }
//
//   @override
//   Future<bool> remind_friends_from_promo_fitt(friend_ids) async {
//     dynamic jsonRequest = {
//       "promo_fitt_friends": friend_ids,
//     };
//     // setLoading(true);
//     if (!App.BASE_URL.contains("api-qa")) {
//       String ts = StringHelper.getTimeStamp();
//       jsonRequest = {"promo_fitt_friends": friend_ids, "timestamp": ts};
//       var res1 = StringHelper().encrypt(jsonEncode(jsonRequest), ts);
//       jsonRequest = {'a': res1};
//       if (kDebugMode) {
//         print("Encrypted payload $jsonRequest");
//       }
//     }
//
//     var response = await App.httpService
//         .postRequest1(REMIND_FRIENDS_FROM_PROMO_FITT, postData: jsonRequest);
//
//     if (response.statusCode == 200) {
//       MyWallet.locked_promo_fitt_reminder_sent = true;
//     }
//     return true;
//   }
//
//   @override
//   Future<bool> getTodayFreezed() async {
//     bool isFreezedAvailable = false;
//
//     var response = await App.httpService.getRequest(GET_POST_LVL_FREEZE);
//     try {
//       if (response.statusCode == 401) return isFreezedAvailable;
//     } catch (err, st) {
//       return isFreezedAvailable;
//     }
//     if (kDebugMode) {
//       print(response.data);
//       print("getTodayFreezed response.statusCode: ${response.statusCode}");
//     }
//     if (response.statusCode == 200) {
//       //{status_code: 200, data: {frozen_days: []}}
//       if (response.data['data']['frozen_days'] != null) {
//         List<dynamic> jsonArray = response.data['data']['frozen_days'];
//         final DateFormat formatterRegular = DateFormat('yyyy-MM-dd');
//         DateTime todayDateTime = DateTime.now();
//
//         final String todatFormat = formatterRegular.format(todayDateTime);
//         todayDateTime = DateTime.parse(todatFormat);
//         App.freezedDate = [];
//         for (var j = 0; j < jsonArray.length; j++) {
//           String serverDates = jsonArray[j];
//           App.freezedDate.add(serverDates.trim());
//           if (serverDates.trim() == todatFormat.trim()) {
//             isFreezedAvailable = true;
//           } else {
//             // freezedDate.add(serverDates);
//           }
//         } //eof if
//       } //eof for
//     } else {
//       return isFreezedAvailable;
//     }
//     return isFreezedAvailable;
//   }
//
//   @override
//   Future<void> sendAppleHealthDataToServer(dynamic post_data) async {
//     print("sendAppleHealthDataToServer called with $post_data");
//     String ts = StringHelper.getTimeStamp();
//
//     dynamic jsonRequest = {
//       'timestamp': ts,
//       'workout_data': post_data,
//     };
//
//     if (!App.BASE_URL.contains("api-qa")) {
//       var res1 = StringHelper().encrypt(jsonEncode(jsonRequest), ts);
//       jsonRequest = {'a': res1};
//     }
//     var otpResponse =
//         await postRequest1(UPLOAD_APPLE_HEALTH_DATA_URL, postData: jsonRequest);
//   }
//
//   Future<void> logOutRequest() async {
//     if (kDebugMode) {
//       print("LOGOUT_URL: $LOGOUT_URL");
//     }
//     String ts = StringHelper.getTimeStamp();
//     dynamic jsonRequest = {'timestamp': ts};
//
//     if (!App.BASE_URL.contains("api-qa")) {
//       var res1 = StringHelper().encrypt(jsonEncode(jsonRequest), ts);
//       jsonRequest = {'a': res1};
//     }
//     var otpResponse = await postRequest1(LOGOUT_URL, postData: jsonRequest);
//     return;
//   }
//
//   static final String first_name = "first_name";
//   static final String username = "username";
//   static final String email = "email";
//   static final String dob = "dob";
//   static final String gender = "gender";
//   static final String height = "height";
//   static final String weight = "weight";
//
//   Future<void> setUserDataInApp(responseData) async {
//     try {
//       //1. id
//       App.id = responseData["id"];
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//
//     //4. username
//     try {
//       App.userName = responseData[username];
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//
//     try {
//       //5. email
//       App.email = responseData[email];
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//
//     //REFERAL data
//
//     if (responseData["referral_link"] != null) {
//       App.referralLink = responseData["referral_link"];
//     }
//     if (responseData["referred_by_firstname"] != null) {
//       App.referred_by_firstname = responseData["referred_by_firstname"];
//     }
//     if (responseData["referred_by_avatar"] != null) {
//       App.referred_by_avatar = responseData["referred_by_avatar"];
//     }
//     if (responseData["total_referrals"] != null) {
//       App.total_referrals = responseData["total_referrals"];
//     }
//     if (responseData["referral_code"] != null) {
//       App.referral_my_code = responseData["referral_code"];
//     }
//     if (responseData["referral_slots_increased"] != null) {
//       if (App.referralSlotsFlag == false) {
//         App.referralSlotsFlag = responseData["referral_slots_increased"];
//       }
//     }
//     if (responseData["referral_slots"] != null) {
//       App.referralSlots = responseData["referral_slots"];
//     }
//
//     if (responseData["op_slots_increased"] != null) {
//       App.originPassSlots = responseData["op_slots_increased"];
//     }
//
//     if (responseData["challenge_notification_seen"] != null) {
//       App.challengesNotificationsSeen.value =
//           responseData["challenge_notification_seen"];
//     }
//     if (responseData["friends_count"] != null) {
//       App.friends_count = responseData["friends_count"];
//       if (kDebugMode) {
//         print('App.friends_count: ${App.friends_count}');
//       }
//     }
//     if (responseData["clubs_count"] != null) {
//       App.clubsCount = responseData["clubs_count"];
//       if (kDebugMode) {
//         print('App.clubs_count: ${App.clubsCount}');
//       }
//     }
//     if (responseData["avatar_created"] != null) {
//       App.avatarCreated = responseData["avatar_created"];
//       if (kDebugMode) {
//         print('App.avatarCreated: ${App.avatarCreated}');
//       }
//     }
//
//     try {
//       //11
//       if (responseData[first_name] != null) {
//         App.firstName = responseData[first_name];
//       }
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//     try {
//       //12
//       if (responseData['image_data'] != null) {
//         App.imageData = responseData['image_data'];
//         if (responseData['image_data']['profile_image'] != null) {
//           App.profileImage = responseData['image_data']['profile_image'];
//         }
//         if (responseData['image_data']['full_image'] != null) {
//           App.avatarFullImage = responseData['image_data']['full_image'];
//         }
//         if (responseData['image_data']['home_page_image'] != null) {
//           App.avatarHomePageImage =
//               responseData['image_data']['home_page_image'];
//         }
//         if (App.avatarHomePageImage.isEmpty) {
//           App.avatarHomePageImage = App.avatarFullImage;
//         }
//         if (responseData['image_data']['right_pose'] != null) {
//           App.avatarFullRightPoseImage =
//               responseData['image_data']['right_pose'];
//         }
//         if (responseData['image_data']['left_pose'] != null) {
//           App.avatarFullLeftPoseImage = responseData['image_data']['left_pose'];
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//
//     try {
//       //13
//       if (responseData[dob] != null) App.profileDob = responseData[dob];
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//
//     try {
//       //14
//       if (responseData[gender] != null) {
//         App.profileGender = responseData[gender];
//       }
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//
//     try {
//       //15
//       if (responseData[height] != null) {
//         App.defaultHeight = responseData[height];
//       }
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//     print("App.defaultHeight: ${App.defaultHeight}");
//     try {
//       //16
//       if (responseData[weight] != null) {
//         App.defaultWeight = responseData[weight];
//       }
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     if (responseData["username"] != null) {
//       App.firstName = responseData["first_name"];
//       App.userName = responseData["username"];
//     }
//     // todo add avatar_created
//     if (responseData["referral_link"] != null) {
//       App.referralLink = responseData["referral_link"];
//     }
//     if (responseData["avatar_gender"] != null) {
//       print("AVATAR GENDER INIT ${responseData["avatar_gender"]}");
//       App.avatarGender = responseData["avatar_gender"];
//     }
//     if (responseData["friends_activities"] != null) {
//       App.activityNotificationList.value = responseData['friends_activities'];
//     }
//     if (responseData['wardrobe_capacity'] != null) {
//       App.wardrobeCapacity = responseData['wardrobe_capacity'];
//     }
//     if (responseData['has_friend'] != null) {
//       App.has_friend = responseData['has_friend'];
//     }
//     if (responseData['player_data'] != null) {
//       if (responseData['player_data']["discord_username"] != null) {
//         App.discord_username = responseData['player_data']["discord_username"];
//       }
//       log("plaayerdatataaenter fadsfds");
//       App.playerData = playerDataFromJson(responseData["player_data"]);
//       log("plaayerdatataaenter ${responseData["player_data"]}");
//       String currentLevel = await setCatDown(responseData["player_data"]);
//
//       try {
//         App.total_active_minutes_today.value =
//             responseData["player_data"]["total_active_minutes"];
//       } catch (e) {
//         if (kDebugMode) print(e);
//       }
//
//       try {
//         App.covered_active_minutes.value =
//             responseData["player_data"]["covered_active_minutes"];
//         print(
//             "App.covered_active_minutes.value updated: ${App.covered_active_minutes.value}");
//       } catch (e) {
//         if (kDebugMode) print("covered_active_minutes: $e");
//       }
//
//       try {
//         App.percentage.value = App.getGoalWidgetPercentage();
//       } catch (e) {
//         if (kDebugMode) print(e);
//       }
//
//       print(
//           "In call App.total_active_minutes.value : ${App.total_active_minutes_today.value}");
//       print(
//           "In call App.covered_active_minutes.value : ${App.covered_active_minutes.value}");
//
//       await saveLvl(currentLevel);
//
//       Future.delayed(Duration(milliseconds: 100), () {
//         SetCategoryColor.setCategoryColor(
//             responseData["player_data"]["category"]);
//       });
//       if (responseData['player_data']["first_level_down"] != null) {
//         App.firstTimeUserLvlDown.value =
//             responseData['player_data']['first_level_down'];
//       }
//       if (responseData['player_data']["level"] != null) {
//         App.playerData.level = responseData['player_data']['level'];
//       }
//
//       if (responseData['player_data']["past_week_winner"] != null) {
//         App.wonInPastWeek = responseData['player_data']["past_week_winner"];
//       }
//       if (responseData['player_data']["past_month_recap"] != null) {
//         App.monthlyRecapNudge = responseData['player_data']["past_month_recap"];
//       }
//       if (responseData['player_data']["past_week_interval"] != null) {
//         App.wonInPastWeekDates =
//             responseData['player_data']["past_week_interval"];
//       }
//       if (responseData['player_data']["past_week_winner_seen"] != null) {
//         App.wonInPastWeekSeen =
//             responseData['player_data']["past_week_winner_seen"];
//       }
//     }
//   }
//
//   Future<String> setCatDown(resPlayeData) async {
//     String currentLevel = "", currentCat = "";
//     try {
//       if (resPlayeData != null) {
//         if (resPlayeData['category'] != null) {
//           currentCat = resPlayeData['category'];
//         }
//
//         if (resPlayeData['level'] != null) {
//           currentLevel = resPlayeData['level'].toString();
//         }
//         if (resPlayeData['levelled_down'] != null) {
//           bool levelled_down = resPlayeData['levelled_down'];
//           if (kDebugMode) {
//             print("LEVEL_DOWN_SERVER levelled_down : $levelled_down");
//           }
//
//           if (levelled_down) {
//             //Level down happen
//             // App.levelCatledDown.value = 1;
//
//             String oldCat = await checkForNewLvlCat();
//             Future.delayed(Duration(milliseconds: 90));
//             App.levelCatledDown = 1;
//             if (kDebugMode) {
//               print(
//                   "LEVEL_DOWN_SERVER levelCatledDown var value  : ${App.levelCatledDown}");
//             }
//             if (kDebugMode) {
//               print(
//                   "LEVEL_DOWN_SERVER server category  : ${resPlayeData['category']}");
//             }
//             if (kDebugMode) {
//               print("LEVEL_DOWN_SERVER oldCat  : $oldCat");
//             }
//
// /* //Moved to server           try {
//               String last = "";
//               String nowNew = App.playerData.category;
//
//               // if (data['from_category'] != null) last = data['from_category'];
//               // if (data['to_category'] != null) nowNew = data['to_category'];
//
//               AmplitudeAnalysis.logEvent20("Levelled Down", eventProperties: {
//                 "lastLevel": (App.playerData.level - 1),
//                 "newLevel": (App.playerData.level),
//                 "lastCategory": last,
//                 "newCategory": nowNew,
//               });
//             } catch (e) {
//               print(e.toString());
//             }*/
//
//             if (currentCat.trim().length > 0) {
//               if (oldCat.trim().length > 0) {
//                 if (currentCat.toLowerCase() != oldCat.toLowerCase()) {
//                   // App.levelCatledDown.value = 2;
//                   App.levelCatledDown = 2;
// /*// moved to server
//                   try {
//                     // if (data['from_category'] != null) last = data['from_category'];
//                     // if (data['to_category'] != null) nowNew = data['to_category'];
//
//                     AmplitudeAnalysis.logEvent20("Levelled Down",
//                         eventProperties: {
//                           "lastLevel": (App.playerData.level - 1),
//                           "newLevel": (App.playerData.level),
//                           "lastCategory": oldCat,
//                           "newCategory": App.playerData.category,
//                         });
//                   } catch (e) {
//                     print(e.toString());
//                   }*/
//                 }
//               }
//             }
//
//             if (kDebugMode) {
//               print(
//                   "LEVEL_DOWN_SERVER levelCatledDown var value  : ${App.levelCatledDown}");
//             }
//
// /*           disabled this which cause the issue
//  String from_category = resPlayeData['from_category'];
//             String to_category = resPlayeData['to_category'];
//             if (from_category != null && to_category != null) {
//               if (from_category
//                       .toLowerCase()
//                       .trim()
//                       .compareTo(to_category.toString().trim()) !=
//                   0) {
//                 // App.levelCatledDown.value = 2;
//                 //TODO: comparion not wokring as expected so commeted now
//                 //App.levelCatledDown = 2;
//               }
//             }*/
//           }
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("LEVEL_DOWN_SERVER$e");
//       }
//     }
//     return currentLevel;
//   }
//
//   Future<String> checkForNewLvlCat() async {
//     String oldoldCat = "";
//     String lastLvl = await StringHelper().getlastLevel();
//     if (lastLvl != null) {
//       if (lastLvl.trim().isNotEmpty) {
//         if (lastLvl.trim().toLowerCase() !=
//             App.playerData.level.toString().trim().toLowerCase()) {
//           // if (App.levelCatledUp > 0) {
//           //Level updated, get old level
//           int oldLevel = int.parse(lastLvl);
//           App.oldLevel = oldLevel;
//           String oldCat = cat.Category.getCategoryFromLevel(oldLevel);
//           App.oldCat = oldCat;
//           oldoldCat = oldCat;
//           // setLevelNumber((oldLevel));
//           // SetCategoryColor.setCategoryColor(oldCat);
//
//           /*Future.delayed(Duration(milliseconds: 2500), () {
//             setLevelNumber((App.playerData.level));
//             SetCategoryColor.setCategoryColor(App.playerData.category);
//             StringHelper().setLastLevel(App.playerData.level.toString());
//           });*/
//           // } else {
//           //   setLevelNumber((App.playerData.level));
//           // }
//
//           // StringHelper().setLastLevel(App.playerData.level.toString());
//         } else {
//           //Save
//           // await saveLvl();
//         }
//       } else {
//         //Save
//         // await saveLvl();
//       }
//     } else {
//       //Save
//       // await saveLvl();
//     }
//
//     return oldoldCat;
//   }
//
//   Future<void> saveLvlDefault() async {
//     // Future.delayed(Duration(milliseconds: 300), () async {
//     // setLevelNumber((App.playerData.level));
//     // update();
//     await StringHelper().setLastLevel(App.playerData.level.toString());
//     if (kDebugMode) {
//       print("LEVEL_DOWN_SERVER saved cat : ${App.playerData.level}");
//     }
//     // });
//   }
//
//   Future<void> saveLvl(value) async {
//     // Future.delayed(Duration(milliseconds: 300), () async {
//     // setLevelNumber((App.playerData.level));
//     // update();
//     await StringHelper().setLastLevel(value.toString());
//     if (kDebugMode) {
//       print("LEVEL_DOWN_SERVER saved cat : $value");
//     }
//
//     // });
//   }
//
//   Future<dynamic> fetch_balances_from_server(
//       String network, bool withAddress) async {
//     var response = await getRequest(USER_BALANCES_URL);
//
//     try {
//       if (response.data["status"] == 401) return null;
//     } catch (err, st) {
//       return null;
//     }
//     if (kDebugMode) {
//       print(
//           "fetch_balances_from_server: ${response.statusCode} ${response.data}");
//     }
//     if (response.data["status_code"] == 200) {
//       dynamic responseData = response.data['data'];
//       if (responseData["fitt_balance"] != null) {
//         MyWallet.fittBalanceInGame = responseData["fitt_balance"].toDouble();
//       }
//       if (responseData['usdc_balance'] != null) {
//         MyWallet.usdcBalanceInGame = responseData["usdc_balance"].toDouble();
//       }
//       if (responseData["wallet_address"] != null) {
//         MyWallet.import_wallet_address = responseData["wallet_address"];
//       }
//       if (responseData["wallet_type"] != null) {
//         MyWallet.import_wallet_type = responseData["wallet_type"];
//       }
//       if (responseData["promo_fitt_balance"] != null) {
//         MyWallet.promo_fitt_balance =
//             responseData["promo_fitt_balance"].toDouble();
//       }
//       if (responseData["show_promo_fitt"] != null) {
//         MyWallet.show_promo_fitt = responseData["show_promo_fitt"];
//       }
//       if (responseData["matic_balance"] != null) {
//         MyWallet.maticBalanceInGame = responseData["matic_balance"].toDouble();
//       }
//       if (response.data["locked_balance"] != null) {
//         MyWallet.locked_promo_fitt_balance =
//             response.data["locked_balance"].toDouble();
//       }
//       if (kDebugMode) {
//         print("fittBalanceInGame: ${MyWallet.fittBalanceInGame}");
//       }
//     } //eof if
//     // print("Returning response");
//     return response;
//   } //eof method
//
//   Future<dynamic> fetch_locked_balances_from_server() async {
//     var response = await getRequest("$LOCKED_PROMO_FITT_BALANCE_URL");
//     // print(response);
//
//     try {
//       if (response.data["status"] == 401) return null;
//     } catch (err, st) {
//       // print("Error in Access Token Update");
//       //TODO: retry server settings
//       // retry_sever_settings();
//       return null;
//     }
//     if (kDebugMode) print(response.data);
//     if (response.data["status_code"] == 200) {
//       MyWallet.locked_promo_fitt_balance =
//           response.data["locked_balance"].toDouble();
//       MyWallet.locked_promo_fitt_reminder_sent = response.data['reminder_sent'];
//       MyWallet.locked_promo_fitt_data = response.data['data'];
//       if (kDebugMode) {
//         print(
//             "locked_promo_fitt_balance: ${MyWallet.locked_promo_fitt_balance}");
//       }
//     } //eof if
//     // print("Returning response");
//     return response;
//   } //eof method
//
//   @override
//   Future<bool> getImportWalletData(String queryString) async {
//     if (kDebugMode) {
//       print("queryString: $queryString");
//     }
//     try {
//       Response response = await App.httpService
//           .getRequest("$WALLET_PARTS_SAVE_URL?$queryString");
//       if (kDebugMode) {
//         print("getImportedWalletData response CODE : ${response.statusCode}");
//         print("getImportedWalletData response : ${response.data}");
//       }
//       if (response.statusCode == 200) {
//         if (response.data['data'] != null) {
//           if (response.data['data']['security_question'] != null) {
//             MyWallet.wallet_import_security_question =
//                 response.data['data']['security_question'];
//           }
//           if (response.data['data']['security_question_id'] != null) {
//             MyWallet.wallet_import_security_question_id =
//                 response.data['data']['security_question_id'].toString();
//           }
//           if (response.data['data']['first_part'] != null) {
//             MyWallet.wallet_import_first_part =
//                 response.data['data']['first_part'];
//           }
//           if (response.data['data']['second_part'] != null) {
//             print(
//                 "response.data['data']['second_part']: ${response.data['data']['second_part']}");
//             MyWallet.wallet_import_second_part = StringHelper()
//                 .decrypt(response.data['data']['second_part'], App.email);
//           }
//           print(
//               "response.data['data'] ${response.data['data']['wallet_address']}");
//           print(
//               "MyWallet.wallet_import_first_part: ${MyWallet.wallet_import_first_part}");
//         }
//         return true;
//       }
//     } catch (e) {}
//     return false;
//   }
//
//   @override
//   Future<void> getWalletImportQuestion() async {
//     var response = await getRequest(WALLET_IMPORT_QUESTION_LIST_URL);
//     try {
//       if (response.data["status"] == 401) return;
//     } catch (err, st) {
//       return;
//     }
//     if (kDebugMode) print("getWalletImportQuestion data: ${response.data}");
//     if (response.data["status_code"] == 200) {
//       Map<String, dynamic> myMap = response.data['data'];
//       MyWallet.wallet_security_questions = [];
//       for (MapEntry entry in myMap.entries) {
//         print('Key: ${entry.key}, Value: ${entry.value}');
//         MyWallet.wallet_security_questions.add({
//           "id": entry.key,
//           "question": entry.value.toString(),
//         });
//       }
//     } //eof if
//   }
//
//   @override
//   Future<bool> save_onchain_txn_data(Map<String, dynamic> post_data) async {
//     String url =
//         WALLET_TXN_SAVE_URL.replaceAll('<wallet>', MyWallet.myWalletAddress);
//     if (kDebugMode) {
//       print("WALLET_TXN_SAVE_URL: $url");
//       print("WALLET_TXN_SAVE_URL Data : $post_data");
//     }
//     String ts = StringHelper.getTimeStamp();
//     post_data['timestamp'] = ts;
//     dynamic jsonRequest = post_data;
//
//     if (!App.BASE_URL.contains("api-qa")) {
//       var res1 = StringHelper().encrypt(jsonEncode(jsonRequest), ts);
//       jsonRequest = {'a': res1};
//     }
//     var otpResponse = await postRequest1(url, postData: jsonRequest);
//     if (kDebugMode) {
//       print(
//           "save_on_chain_txn_data status:${otpResponse.statusCode} data ${otpResponse.data}");
//     }
//     return false;
//   }
}

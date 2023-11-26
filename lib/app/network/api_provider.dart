// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// import 'interceptor.dart';
//
// class ApiProvider {
//   Dio? dio;
//   ApiProvider() {
//     BaseOptions options =
//         BaseOptions(receiveTimeout: 10000, connectTimeout: 5000);
//     dio = Dio(options);
//     dio!.interceptors.add(LoggingInterceptor(this.dio));
//   }
//
//   Future<dynamic> get(String url) async {
//     var responseJson;
//     try {
//       final response = await dio!.get(url);
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//
//       throw Exception('No Internet connection');
//     } catch (e) {
//       throw e;
//     }
//     print('api get recieved!');
//     return responseJson;
//   }
//
//   Future<dynamic> post(String url, dynamic body,
//       {Map<String, String>? headers}) async {
//     print('Api Post, url $url');
//     print('body $body');
//     var responseJson;
//
//     try {
//       final response =
//           await dio!.post(url, data: body, options: Options(headers: headers));
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//
//       throw Exception('No Internet connection');
//     } catch (e) {
//       throw e;
//     }
//     print('api post.');
//     return responseJson;
//   }
//
//   dynamic _returnResponse(Response response) {
//     switch (response.statusCode) {
//       case 200:
//         var responseJson = json.decode(response.toString());
//         print(responseJson);
//         return responseJson;
//       case 400:
//         throw Exception(response.toString());
//       case 401:
//         throw Exception(response.toString());
//       case 403:
//         throw Exception(response..toString());
//       case 500:
//       default:
//         throw Exception(
//             'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//     }
//   }
// }

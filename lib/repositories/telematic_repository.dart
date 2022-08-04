import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:live_tracking/helpers/flash_message_helper.dart';
import 'package:live_tracking/helpers/user_helper.dart';
import 'package:live_tracking/models/base_response.dart';
import 'package:live_tracking/models/telematic.dart';
import 'package:live_tracking/models/user.dart';
import 'package:live_tracking/repositories/base_repository.dart';
import 'package:live_tracking/repositories/geolocation_repository.dart';
import 'package:live_tracking/repositories/main_repository.dart';
import 'package:live_tracking/services/hive_service.dart';
import 'package:live_tracking/utils/constants.dart';
import 'package:live_tracking/utils/enums.dart';
import 'package:live_tracking/utils/exceptions.dart';
import 'package:live_tracking/utils/get_it.dart';
import 'package:live_tracking/utils/typedefs.dart';
import 'package:logger/logger.dart';

class TelematicRepository extends BaseRepository {

Future<void> init(SendPort port) async {
    try {
      final dio = _setupDio('en', false);

      GetItContainer.initializeConfiginInIsolates(dio);

      Timer.periodic(const Duration(milliseconds : 5000), (timer) async{
        try{
          final devices = await GeolocationRepository().getCurrentLocation();
          final encoded = jsonEncode(devices);

          port.send(encoded);
        }catch (e){
          Logger().e(e);
        }
      });
    } catch (e) {
      GetIt.I<FlashMessageHelper>()
          .showError(e.toString(), duration: const Duration(seconds: 5));
    }
  }

  Dio _setupDio(String lang, bool isUserIntercept) {
    final options = BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: 16000,
      receiveTimeout: 16000,
      sendTimeout: 16000,
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-localization': lang,
        'Access-Control-Allow-Origin': '*',
      },
    );

    final dio = Dio(options);
    return dio;
  }
}

// ignore_for_file: lines_longer_than_80_chars

// import 'dart:async';
// import 'dart:isolate';

// import 'package:dio/dio.dart';
// import 'package:flutter_isolate/flutter_isolate.dart';
// import 'package:get_it/get_it.dart';
// import 'package:live_tracking/helpers/flash_message_helper.dart';
// import 'package:live_tracking/helpers/user_helper.dart';
// import 'package:live_tracking/services/hive_service.dart';
// import 'package:live_tracking/utils/constants.dart';
// import 'package:live_tracking/utils/get_it.dart';

// /// Used to initialize the application in splashscreen
// class TelematicRepository {
//   /// The method is used to initialize the Application
//   /// Setup the DI container, Dio, Hive and etc.
//   Future<void> init(String lang) async {
//     try {
//       // final isolate = await FlutterIsolate.spawn((message) {
//       //   fetc
//       // }, message)
//       final dio = _setupDio(lang);

//       // GetItContainer.initializeConfigInIsolates(dio);

//       await GetIt.I<HiveService>().init();
//     } catch (e) {
//       GetIt.I<FlashMessageHelper>().showError(
//         e.toString(),
//         duration: const Duration(seconds: 15),
//       );
//     }
//   }

//   void fetchLatesDevices(SendPort port){
//     final dio = TelematicRepository()._setupDio('en', isUserIntercept: false);
//     // GetItContainer.initializeConfigInIsolates(dio);

//     // Timer.periodic(const Duration(milliseconds : 5000), (timer) async { 
//     //   try {
//     //     final device = await Device
//     //   }
//     // });
//   }

//   Dio _setupDio(String lang, {bool isUserIntercept = false}) {
//     final options = BaseOptions(
//       baseUrl: kBaseUrl,
//       connectTimeout: 16000,
//       receiveTimeout: 16000,
//       sendTimeout: 16000,
//       headers: <String, dynamic>{
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'X-localization': lang,
//         'Access-Control-Allow-Origin': '*',
//         'X-Api-Key' : 'eyJpdiI6IktEaW9xQUpKS1hFcXVOY3djL290Ymc9PSIsInZhbHVlIjoicXJYNW9oRFVJb3J3Yk4yWGdjczRBOFYxMTJsRksyTFZNZzJYdStMYThWL3BQWDNOMnZkWWd1TWgrTUw1Y0FaViIsIm1hYyI6Ijg1MGVmOThmNTYzZTZmNjJjZGFlZDFjNzVhYTc4ZjYxZWMyZDAzMDYzOTA2ZTk5NGM4MjIxMWZlOTRiNGYzMTciLCJ0YWciOiIifQ==',
//         'X-External-Id' : 'indratest',
//         'X-Tracker-Id' : 'indratest'
//       },
//     );

//     final dio = Dio(options);

//     // if (isUseLogger) {
//     //   dio.interceptors
//     //       .add(LogInterceptor(responseBody: true, requestBody: true));
//     // }

//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           return handler.next(response);
//         },
//         onError: (DioError e, handler) {
//           if (e.response != null && e.response!.statusCode == 401) {
//             GetIt.I<UserHelper>().logout();
//           }
//           return handler.next(e);
//         },
//       ),
//     );

//     return dio;
//   }
// }


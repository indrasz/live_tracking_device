// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:live_tracking/helpers/flash_message_helper.dart';
import 'package:live_tracking/helpers/user_helper.dart';
import 'package:live_tracking/repositories/telematic_repository.dart';
import 'package:live_tracking/services/hive_service.dart';
import 'package:live_tracking/utils/constants.dart';
import 'package:live_tracking/utils/get_it.dart';

/// Used to initialize the application in splashscreen
class MainRepository {
  /// The method is used to initialize the Application
  /// Setup the DI container, Dio, Hive and etc.
  Future<void> init(String lang) async {
    try {
      final dio = _setupDio(lang);
      GetItContainer.initializeConfig(dio);

      // Timer.periodic(const Duration(milliseconds: 5000), (timer) async{
      //   try{
      //     final telematic = await TelematicRepository().sendTelematic(altitude, bearing, ion, hdop, lat)
      //   }
      // });

    } catch (e) {
      GetIt.I<FlashMessageHelper>().showError(
        e.toString(),
        duration: const Duration(seconds: 15),
      );
    }
  }

  Dio _setupDio(String lang, {bool isUserIntercept = false}) {
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
        'X-Api-Key':
            'eyJpdiI6IktEaW9xQUpKS1hFcXVOY3djL290Ymc9PSIsInZhbHVlIjoicXJYNW9oRFVJb3J3Yk4yWGdjczRBOFYxMTJsRksyTFZNZzJYdStMYThWL3BQWDNOMnZkWWd1TWgrTUw1Y0FaViIsIm1hYyI6Ijg1MGVmOThmNTYzZTZmNjJjZGFlZDFjNzVhYTc4ZjYxZWMyZDAzMDYzOTA2ZTk5NGM4MjIxMWZlOTRiNGYzMTciLCJ0YWciOiIifQ==',
        'X-External-Id': 'indratest',
        'X-Tracker-Id': 'indratest'
      },
    );

    final dio = Dio(options);

    // if (isUserIntercept) {
    //   dio.interceptors.add(
    //     LogInterceptor(responseBody: true, requestBody: true),
    //   );
    // }

    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) {
    //       return handler.next(options);
    //     },
    //     onResponse: (response, handler) {
    //       return handler.next(response);
    //     },
    //     onError: (DioError e, handler) {
    //       if (e.response != null && e.response!.statusCode == 401) {
    //         GetIt.I<UserHelper>().logout();
    //       }
    //       return handler.next(e);
    //     },
    //   ),
    // );

    return dio;
  }
}

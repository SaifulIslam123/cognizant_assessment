import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum HttpMethod { POST, GET, PUT, DELETE, PATCH }

class AppApiClient {
  final dio = createDio();

  AppApiClient._internal();

  static final _singleton = AppApiClient._internal();

  factory AppApiClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(baseUrl: "https://cognizant.free.beeceptor.com"));
    return dio;
  }

  static logPrint(dynamic msg) {
    if (kDebugMode) {
      print(msg);
    }
  }

}
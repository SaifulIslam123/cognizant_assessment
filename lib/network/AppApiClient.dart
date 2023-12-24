import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String BASE_URL = "https://cognizantv2.free.beeceptor.com";

enum HttpMethod { POST, GET, PUT, DELETE, PATCH }

class AppApiClient {
  final dio = createDio();

  AppApiClient._internal();

  static final _singleton = AppApiClient._internal();

  factory AppApiClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(baseUrl: BASE_URL));
    return dio;
  }

  static logPrint(dynamic msg) {
    if (kDebugMode) {
      print(msg);
    }
  }
}

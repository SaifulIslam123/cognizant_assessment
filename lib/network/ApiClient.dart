import 'package:cognizant_assessment/env/BuildEnvironment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum HttpMethod { POST, GET, PUT, DELETE, PATCH }

class ApiClient {
  final dio = createDio();

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(baseUrl: BuildEnvironment.environment.baseUrl));
    return dio;
  }

  static logPrint(dynamic msg) {
    if (kDebugMode) {
      print(msg);
    }
  }
}

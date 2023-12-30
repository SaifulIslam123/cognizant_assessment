import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'AppApiClient.dart';
import 'Result.dart';

abstract class BaseDataSource {
  final apiErrorMessage = "Api Error occurred";

  @protected
  Future<Result> executeApiRequest(Dio _dio, String url, HttpMethod method,
      Map<String, dynamic>? params, Function modelFromJson) async {
    try {
      Response response;

      _dio.options.headers['Accept'] = 'application/json';
      _dio.options.headers['Content-Type'] = 'application/json';

      if (method == HttpMethod.GET) {
        response = await _dio.get(url, queryParameters: params);
      } else {
        response = await _dio.patch(url, data: params);
      }
      if (response.statusCode == 200) {
        return Result.success(modelFromJson(response.data), null);
      } else {
        return Result.error(apiErrorMessage, response.statusCode ?? -1);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Result.error(e.message, e.response?.statusCode ?? -1);
      } else {
        AppApiClient.logPrint("DioError: $e");
        return Result.error(e.message, e.response?.statusCode ?? -1);
      }
    } catch (error, stacktrace) {
      final errorMessage = error.toString().substring(11);
      AppApiClient.logPrint("$errorMessage:  $error stackTrace: $stacktrace");
      return Result.error(errorMessage, -1);
    }
  }
}

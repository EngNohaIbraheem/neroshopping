import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:neroshopping/core/config/shered_perferences.dart';

class ApiService {
  late final Dio _authDio;

  ApiService(this._authDio) {
    _initializeInterceptors();
  }
  void _setDioOptions() {
    String? token = CashHelper.getData(key: MyCashKey.token);
    _authDio.options
      ..baseUrl = Constant.baseUrl
      ..receiveDataWhenStatusError = true
      ..headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
  }

  void _initializeInterceptors() {
    _authDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('REQUEST[ ${options.method} ]  => PATH : ${options.path}');
          log('Headers: ${options.headers}');
          log('Data:${options.data}');
          log('Query:${options.queryParameters}');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('RESPONSE [ ${response.statusCode} ]  => PATH : ${response.requestOptions.path}');
          log('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          log('ERROR [ ${error.response?.statusCode} ]  => PATH : ${error.requestOptions.path}');
          log('Error Message: ${error.message}');
          log('Error Data :${error.response?.data}');
          handler.reject(error);
        },
      ),
    );
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Object data,
  }) async {
    _setDioOptions();
    return await _authDio.post(url, queryParameters: query, data: data);
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    data,
  }) async {
    _setDioOptions();
    return await _authDio.get(url, queryParameters: query);
  }

  Future<Response> updateData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    _setDioOptions();
    return await _authDio.get(url, queryParameters: query, data: data);
  }

  Future<Response> deletData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    _setDioOptions();
    return await _authDio.delete(url, queryParameters: query, data: data);
  }
}

class Constant {
  static const String baseUrl =
  'https://probar-ps.com/api/v1/';
}

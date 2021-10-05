import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:get/get.dart' hide MultipartFile, Response;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:queen/queen.dart';
import '../comman/services/auth_service.dart';

// ignore: non_constant_identifier_names
final Api = LaravelApi();

class LaravelApi {
  Dio get dio {
    final _dio = Dio(
      BaseOptions(
        // baseUrl: 'http://192.168.1.21:8000/',

        baseUrl: kServerUrl,
        validateStatus: (_) => true,
        followRedirects: false,
        contentType: 'application/json',
        headers: {
          'accept': 'application/json',
        },
      ),
    );
    if (kDebugMode) {
      // ! Comment to disable logs
      _dio.interceptors
          .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    }

    return _dio;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
  }) async {
    return dio.get(
      (Get.locale?.languageCode ?? 'ar') + '/api' + path,
      queryParameters: query,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
        'accept-lang': Get.locale?.languageCode ?? 'ar',
        ...headers,
      }),
    );
  }

  Future<Response> post(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
  }) async {
    return dio.post(
      (Get.locale?.languageCode ?? 'ar') + '/api' + path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          if (attachToken)
            HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
          'accept-lang': Get.locale?.languageCode ?? 'ar',
          ...headers,
        },
        contentType: contentType,
      ),
    );
  }

  Future<Response> put(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
  }) async {
    return dio.put(
      (Get.locale?.languageCode ?? 'ar') + '/api' + path,
      data: body,
      queryParameters: query,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
        'accept-lang': Get.locale?.languageCode ?? 'ar',
        ...headers,
      }),
    );
  }

  Future<Response> delete(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
  }) async {
    return dio.delete(
      (Get.locale?.languageCode ?? 'ar') + '/api' + path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
          'accept-lang': Get.locale?.languageCode ?? 'ar',
          ...headers,
        },
      ),
    );
  }
}

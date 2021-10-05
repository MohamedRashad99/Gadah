import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:queen/queen.dart';
import '../comman/services/auth_service.dart';

final D = DioUtil();

class DioUtil {
  final String url;
  DioUtil([this.url = '']);
  Dio get dio {
    final _dio = Dio(
      BaseOptions(
        baseUrl: url,
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
      // _dio.interceptors
      //   .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    }

    return _dio;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
  }) async {
    return dio.get(
      path,
      queryParameters: query,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
        'accept-lang': Get.locale!.languageCode,
        ...headers,
      }),
    );
  }

  Future<Response> post(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
  }) async {
    return dio.post(
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          if (attachToken)
            HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
          'accept-lang': Get.locale!.languageCode,
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
      path,
      data: body,
      queryParameters: query,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
        'accept-lang': Get.locale!.languageCode,
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
      path,
      data: body,
      queryParameters: query,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: AuthService.userTokenWithBearer,
          'accept-lang': Get.locale!.languageCode,
          ...headers,
        },
      ),
    );
  }
}

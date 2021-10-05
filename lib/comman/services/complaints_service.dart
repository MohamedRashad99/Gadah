import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/modules/shared/complains/models/complain.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:laravel_exception/laravel_exception.dart';

class ComplaintsService {
  Future<void> crateOne({
    required String title,
    required String msg,
    required File image,
    required int orderId,
  }) async {
    final res = await Api.post('/complaints',
        body: FormData.fromMap({
          'title': title,
          'massage': msg,
          'images[0]': await MultipartFile.fromFile(image.path),
          'order_id': orderId,
        }));
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException(res.data);
    }
  }

  Future<ComplianEntity> findOneById(int id) async {
    final res = await Api.get('/complaints/$id');
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException(res.data);
    }
    return ComplianEntity.fromMap(res.data);
  }

  Future<List<ComplianEntity>> findMany([int pageNo = 1]) async {
    final res = await Api.get(kCompalints, query: {'page': pageNo});
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException(res.data);
    }
    return (res.data['data'] as List)
        .map((e) => ComplianEntity.fromMap(e))
        .toList();
  }
}

import 'dart:async';
import 'dart:io';

import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/modules/client/catigories/models/category.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:laravel_exception/laravel_exception.dart';

class CatigoriesService {
  CatigoriesService._();
  static Future<List<CategoryModel>> findMany() async {
    final res = await Api.get(kCategories);
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return (res.data as List)
        .map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  // static Future<CategoryModel> findOneById(int id) async {
  //   final res = await D.get(kCategorieyById.replaceFirst(':id', id.toString()));
  //   if (res.statusCode != HttpStatus.ok) throw  LaravelException.parse(res);
  //   return CategoryModel.fromMap(res.data as Map<String, dynamic>);
  // }
}

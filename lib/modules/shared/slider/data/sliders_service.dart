import 'dart:async';

import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:gadha/modules/shared/slider/models/slider_model.dart';
import 'package:laravel_exception/laravel_exception.dart';

class SliderService {
  SliderService._();
  static Future<List<SliderModel>> getHomeSlides() async {
    final res = await Api.get(kSlider);
    if (res.statusCode != 200) throw LaravelException.parse(res.data);
    return (res.data as List).map((e) => SliderModel.fromMap(e)).toList();
  }
}

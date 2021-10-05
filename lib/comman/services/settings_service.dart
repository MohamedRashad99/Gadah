import 'dart:async';
import 'dart:io';

import 'package:gadha/comman/config/network_constents.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:gadha/comman/models/shared/setting_entity.dart';
import 'package:gadha/helpers/laravel.dart';

class SettingsService {
  Future<SettingEntity> getAppSettings() async {
    final resp = await Api.get(
      kAppSettings,
    );
    if (resp.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(resp.data);
    }
    return SettingEntity.fromMap(resp.data['setting']);
  }
}

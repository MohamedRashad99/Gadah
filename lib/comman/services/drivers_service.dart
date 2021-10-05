import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:laravel_exception/laravel_exception.dart';

class DriverSerivce {
  Future<void> uploadBankValidation(File file) async {
    final res = await Api.post(
      kBankBills,
      body: FormData.fromMap(
        {'image': await MultipartFile.fromFile(file.path)},
      ),
    );
    if (res.statusCode != HttpStatus.created) {
      throw LaravelException.parse(res.data);
    }
  }
}

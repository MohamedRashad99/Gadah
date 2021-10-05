import 'dart:async';
import 'dart:io';

import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/modules/driver/bank_bills/models/bank_bill.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:laravel_exception/laravel_exception.dart';

class BankBillsService {
  Future<List<BankBill>> findMany([int pageNo = 1]) async {
    final res = await Api.get(kBankBills, query: {'page': pageNo});
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException(res.data);
    }
    return (res.data as List).map((e) => BankBill.fromMap(e)).toList();
  }
}

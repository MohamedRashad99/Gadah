import 'package:dio/dio.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:gadha/modules/shared/order_bills/models/bill.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:queen/queen.dart';

Future<List<OrderBill>> findMany(int orderId) async {
  final route = kFindOrderById.replaceAll(':id', orderId.toString());
  final res = await Api.get(route);
  if (res.statusCode != HttpStatus.ok) {
    throw LaravelException.parse(res.data);
  }

  return (res.data as List).map((e) => OrderBill.fromJson(e)).toList();
}

OrderBill? orderBill;
Future<void> createOne({
  required num amount,
  required int orderId,
  required File image,
}) async {
  final res = await Api.post(
    '/bills',
    body: FormData.fromMap({
      'amount': amount,
      'order_id': orderId,
      'image': await MultipartFile.fromFile(image.path),
    }),
  );
  if (res.statusCode == HttpStatus.ok) {
    orderBill = OrderBill.fromJson(res.data);
  }
  if (res.statusCode != HttpStatus.ok) {
    throw LaravelException.parse(res.data);
  }
}

Future<String> deleteOne(int orderId, num billId) async {
  final res = await Api.delete('/orders/$orderId/bills/$billId');
  if (res.statusCode != HttpStatus.ok) {
    throw LaravelException.parse(res.data);
  }
  return res.data['message'];
}

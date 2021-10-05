import 'package:dio/dio.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:queen/queen.dart';

class OrdersRepo {
  Future<void> createOne(Map<String, dynamic> body) async {
    final res = await Api.post('/client/orders', body: FormData.fromMap(body));
    if (res.statusCode != HttpStatus.created) {
      throw LaravelException.parse(res.data);
    }
  }

  Future<void> takeOrder(OrderEntity order) async {
    final res = await Api.get('/client/orders/${order.id}/take_order');
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
  }

  Future<void> alertWithDriverArrived(OrderEntity order) async {
    final res = await Api.get('/driver/arravie_drop_place/${order.id}');
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
  }

  Future<List<OrderEntity>> findOrdersToAccept([int page = 1]) async {
    final res = await Api.get(
      '/driver/orders',
      query: {'page': page, 'status': 'to_offer'},
    );
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }

    return (res.data['data'] as List)
        .map((e) => OrderEntity.fromMap(e))
        .toList();
  }

  Future<List<OrderEntity>> findOrdersInProgress([int page = 1]) async {
    final res = await Api.get(
      '/driver/orders',
      query: {'page': page, 'status': 'in_progress'},
    );
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return (res.data['data'] as List)
        .map((e) => OrderEntity.fromMap(e))
        .toList();
  }

  Future<List<OrderEntity>> findOrdersDriverDoneOrders([int page = 1]) async {
    final res = await Api.get(
      '/driver/orders',
      query: {'page': page, 'status': 'done'},
    );
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return (res.data['data'] as List)
        .map((e) => OrderEntity.fromMap(e))
        .toList();
  }

  Future<List<OrderEntity>> findDriverOrdersByState(int state,
      [int page = 1]) async {
    //if (state == 2) return findDriverOrdersInProgress(page);
    final res = await Api.get(
      '/orders/driver_orders',
      query: {
        'page': page,
        'status': state,
      },
    );
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return List.from(
        (res.data['data'] as List).map((e) => OrderEntity.fromMap(e)));
  }

  Future<List<OrderEntity>> findDriverOrdersInProgress([int page = 1]) async {
    final res = await Api.get(
      '/driver/orders',
      query: {
        'page': page,
        'driver_id': AuthService.currentUser!.id,
      },
    );
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return List.from((res.data as List)
            .map((e) => OrderEntity.fromMap(e as Map<String, dynamic>)))
        .cast<OrderEntity>();
  }

  Future<List<OrderEntity>> findUserOrders([int page = 1]) async {
    final res = await Api.get(
      '/client/orders',
      query: {'page': page},
    );
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return (res.data['data'] as List)
        .map((e) => OrderEntity.fromMap(e))
        .toList();
  }
}

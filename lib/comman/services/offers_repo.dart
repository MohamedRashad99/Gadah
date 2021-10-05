import 'package:gadha/comman/models/offer.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:queen/queen.dart';

class OffersRepo {
  Future<void> offerToOrder(int orderId, double price) async {
    final res = await Api.post(
      '/offers',
      body: {
        'price': price,
        'order_id': orderId,
      },
    );
    if (res.statusCode != HttpStatus.ok) {
      throw res.data['message'];
    }
  }

  Future<void> acceptOffer(int orderId, int offerId) async {
    final res = await Api.post(
      '/orders/$orderId/offers/$offerId',
    );
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
  }

  Future<List<OfferEntity>> loadUseerIncOffers(int orderId) async {
    final res = await Api.get('/orders/$orderId/offers');
    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return (res.data['data'] as List)
        .map((e) => OfferEntity.fromMap(e))
        .toList();
  }
}

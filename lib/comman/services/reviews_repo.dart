import 'package:gadha/comman/models/review.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:queen/queen.dart';

class ReviewsRepo {
  static Future<String> rateOrder(
    int orderId, {
    required String comment,
    required double stars,
  }) async {
    final res = await Api.post(
      '/orders/$orderId/review',
      body: {
        'rate': stars,
        'comment': comment,
      },
    );
    if (res.statusCode != HttpStatus.created) {
      throw res.data['message'];
    }
    return res.data['message'];
  }

  static Future<List<ReviewModel>> finManyByUserId(int userId,
      [int page = 1]) async {
    final res = await Api.get(
      '/user/reviews',
      query: {
        'page': page,
        'user_id': userId,
      },
    );
    log(res.data.toString());

    if (res.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(res.data);
    }
    return (res.data['data'] as List)
        .map((e) => ReviewModel.fromMap(e))
        .toList();
  }
}

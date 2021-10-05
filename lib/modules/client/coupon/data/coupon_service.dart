import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:gadha/modules/client/coupon/model/coupon_model.dart';

import 'package:queen/queen.dart';

class CouponService {
  CouponService._();

  static Future<CouponModel> findOny(String coupon) async {
    final res = await Api.get(kCoupon, query: {'coupon': coupon});
    if (res.statusCode != HttpStatus.ok) {
      throw res.data['error'];
    }
    return CouponModel.fromMap(res.data);
  }
}

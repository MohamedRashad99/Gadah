import 'package:flutter_test/flutter_test.dart';
import 'package:gadha/helpers/coupon_discount_manager.dart';

void main() {
  test('when discount  == 0 it will throw AssertionError ', () {
    expect(
      () => DiscountManager.getTotalAfterDiscount(100, 0),
      throwsAssertionError,
      reason: 'Discount must not be 0',
    );
  });
  test('when discount < 0 it will throw AssertionError ', () {
    expect(
      () => DiscountManager.getTotalAfterDiscount(100, -5),
      throwsAssertionError,
      reason: 'Discount must not be < 0',
    );
  });
  test('when discount > 100 it will throw AssertionError ', () {
    expect(
      () => DiscountManager.getTotalAfterDiscount(100, 101),
      throwsAssertionError,
      reason: 'Discount must not be > 100',
    );
  });

  test('when percent is fractional it will work ', () {
    expect(
      DiscountManager.getTotalAfterDiscount(1000, 6.5),
      935,
    );
  });
  test('when percent is valid integer it will work ', () {
    expect(
      DiscountManager.getTotalAfterDiscount(123456, 6),
      116048.64,
    );
  });
}

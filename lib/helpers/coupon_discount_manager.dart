class DiscountManager {
  DiscountManager._();

  static num getTotalAfterDiscount(num totalPrice, num discount) {
    return totalPrice - discount;
  }
}

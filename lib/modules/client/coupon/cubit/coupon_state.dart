part of 'coupon_cubit.dart';

@immutable
abstract class CouponState {}

class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class CouponError extends CouponState {
  final String msg;
  CouponError(this.msg);
}

class CouponLoaded extends CouponState {
  final CouponModel coupon;
  CouponLoaded(this.coupon);
}

class CouponNotFound extends CouponState {}

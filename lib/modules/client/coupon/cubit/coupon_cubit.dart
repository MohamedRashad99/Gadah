import 'package:bloc/bloc.dart';
import 'package:gadha/modules/client/coupon/data/coupon_service.dart';
import 'package:gadha/modules/client/coupon/model/coupon_model.dart';

import 'package:meta/meta.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit() : super(CouponInitial());

  Future<void> check(String coupon) async {
    emit(CouponLoading());
    try {
      final _coupon = await CouponService.findOny(coupon);
      emit(CouponLoaded(_coupon));
    } catch (e) {
      emit(CouponError(e.toString()));
    }
  }
}

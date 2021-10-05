import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/models/shared/places/palce_details.dart';
import 'package:gadha/modules/client/coupon/model/coupon_model.dart';
import 'package:gadha/modules/client/home/page.dart';
import 'package:gadha/modules/client/make_order/views/order_items/cubit/order_items_cubit.dart';
import 'package:gadha/comman/services/orders_repo.dart';
import 'package:gadha/comman/services/places_service.dart';
import 'package:gadha/modules/client/orders/cubit/user_offers_cubit.dart';
import 'package:gadha/modules/shared/curren_location/cubit/current_location_cubit.dart';
import 'package:gadha/modules/shared/sucess.dart';

import 'package:meta/meta.dart';
import 'package:place_picker/place_picker.dart' as pp;
import 'package:get/get.dart' hide MultipartFile;
import 'package:queen/queen.dart';
import '/comman/extensions.dart';

part 'make_order_state.dart';

class MakeOrderCubit extends Cubit<MakeOrderState> {
  final OrderItemsCubit orderItemsCubit;
  final PlaceDetailsEntity store;
  final UserOrdersCubit userOrdersCubit;

  MakeOrderCubit(this.orderItemsCubit, this.store, this.userOrdersCubit)
      : super(MakeOrderInitial());
  CouponModel? _coupon;
  CouponModel? get coupon => _coupon;

  bool dropToHome = true;
  double? dropLat;
  double? dropLang;
  set coupon(CouponModel? c) {
    _coupon = c;
    emit(MakeOrderInitial());
  }

  pp.LocationResult? _locationResult;
  pp.LocationResult? get locationResult => _locationResult;
  set locationResult(pp.LocationResult? c) {
    _locationResult = c;
    dropLat = c!.latLng!.latitude;
    dropLang = c.latLng!.longitude;
    emit(MakeOrderInitial());
  }

  Future<void> makeOrderToHome() async {
    final latLang = BlocProvider.of<CurrentLocationCubit>(Q.context)
        .currentLocation!
        .toLatLng();
    dropLat = latLang.latitude;
    dropLang = latLang.longitude;
    return makeOrder();
  }

  Future<void> makeOrder() async {
    final _placesService = PlacesService();

    try {
      if (orderItemsCubit.items.isEmpty) {
        throw 'must_enter_order_items_names'.tr;
      } else if (dropLang == null || dropLat == null) {
        throw 'must_pick_location'.tr;
      }

      final _products = <Map<String, dynamic>>[];
      for (final prod in orderItemsCubit.items) {
        _products.add(
          {
            'name': prod.name,
            'quantity': prod.count,
            if (prod.photo != null)
              'image': await MultipartFile.fromFile(prod.photo!.path),
          },
        );
      }
      final orderBody = {
        'coupon': _coupon ?? '',
        'pick_place': {
          'name': (await _placesService.findPlaceDetails(store.placeId))
              .result
              .name,
          'longitude': store.geometry!.location.lng.toString(),
          'latitude': store.geometry!.location.lat.toString(),
          'address': store.formattedAaddress,
        },
        'drop_place': {
          'name': locationResult != null
              ? (await _placesService
                      .findPlaceDetails(locationResult!.placeId!))
                  .result
                  .name
              : 'home',
          'longitude': dropLang.toString(),
          'latitude': dropLat.toString(),
          'address': locationResult != null
              ? locationResult?.formattedAddress
              : await _placesService.findPlaceDetailsByLatLang(
                  dropLat!,
                  dropLang!,
                ),
        },
        'products': _products,
      };
      await OrdersRepo().createOne(orderBody);
      await Q.replaceAll(const ClientHomePage());
      await Q.to(const OrderSubmitted());
      Q.alertWithSuccess('order_created_sucessfully'.tr);
      userOrdersCubit.refresh();
    } catch (e) {
      Q.alertWithErr(e);
      log(e.toString());
    }
  }
}

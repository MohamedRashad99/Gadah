import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/comman/services/orders_repo.dart';
import 'package:gadha/comman/services/places_service.dart';
import 'package:gadha/helpers/auth.dart';
import 'package:gadha/modules/client/coupon/dialog.dart';
import 'package:gadha/modules/client/coupon/model/coupon_model.dart';
import 'package:gadha/modules/client/make_order/models/order_item_to_add.dart';
import 'package:gadha/modules/client/make_order/views/payment_methods_row.dart';
import 'package:gadha/modules/client/orders/cubit/user_offers_cubit.dart';
import 'package:gadha/modules/shared/sucess.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/items/cart_item.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:place_picker/place_picker.dart' as pp;
import 'package:get/get.dart' hide MultipartFile;
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/header_edit_container.dart';

class CustomService extends StatefulWidget {
  const CustomService({Key? key}) : super(key: key);
  @override
  _CustomServiceState createState() => _CustomServiceState();
}

class _CustomServiceState extends State<CustomService> {
  final _products = <OrderItemToAdd>[const OrderItemToAdd(name: '')];
  bool _isLoading = false;
  CouponModel? _discountCoupon;
  pp.LocationResult? _pickLocation;
  pp.LocationResult? _dropLocation;

  Future<void> _submit() async {
    try {
      if (!AuthService.isLoggedIn) {
        ifIsNotLoggedInAskElseAct(() {});
        return;
      }
      setState(() => _isLoading = true);
      if (_pickLocation == null) throw 'must_pick_pick_location'.tr;
      if (_dropLocation == null) throw 'must_pick_drop_location'.tr;
      if (_products.first.name.trim().isEmpty) {
        throw 'must_enter_product_name'.tr;
      }
      // await  createOrder
      final _placesService = PlacesService();

      final orderBody = {
        'coupon': _discountCoupon ?? '',
        'pick_place': {
          'name':
              (await _placesService.findPlaceDetails(_pickLocation!.placeId!))
                  .result
                  .name,
          'longitude': _pickLocation!.latLng!.longitude.toString(),
          'latitude': _pickLocation!.latLng!.latitude.toString(),
          'address': _pickLocation!.formattedAddress,
        },
        'drop_place': {
          'name':
              (await _placesService.findPlaceDetails(_dropLocation!.placeId!))
                  .result
                  .name,
          'longitude': _dropLocation!.latLng!.longitude.toString(),
          'latitude': _dropLocation!.latLng!.latitude.toString(),
          'address': _dropLocation!.formattedAddress,
        },
        'products': [
          {
            'name': _products.first.name,
            'quantity': _products.first.count,
            if (_products.first.photo != null)
              'image': await MultipartFile.fromFile(_products.first.photo!.path)
          }
        ],
      };
      await OrdersRepo().createOne(orderBody);
      await Q.replace(const OrderSubmitted());
      UserOrdersCubit.of(context).refresh();
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      Q.alertWithErr(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StanderedAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _bFAB(),
      body: SafeArea(
        child: ListView(
          children: [
            _bAppBar(),
            const SizedBox(height: 15),
            ..._bPrdouct(),
            ..._bPaymentRow(),
            ..._bDiscoutCoupon(),
            const Divider(),
            _bPickLocation(),
            _bDropLocation(),
            SizedBox(height: height * .06),
          ],
        ),
      ),
    );
  }

  Widget _bFAB() => SizedBox(
        width: width * .9,
        height: height * .06,
        child: FloatingActionButton(
            isExtended: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 0,
            onPressed: _submit,
            child: _isLoading
                ? const CenterLoading()
                : CustomMainButton(
                    onTap: _submit,
                    text: 'submit_order'.tr,
                    dropShadow: true,
                    borderRaduis: 25,
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                    height: size.height * 0.06,
                  )),
      );
  Widget _bAppBar() => StanderedAppBar(
        appBarType: AppBarType.navigator,
        centerChild: Text(
          'custom_request'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
  List<Widget> _bPrdouct() => [
        HeaderAndEditContainer(title: 'products_toBuy'.tr),
        CartItemWidget(
          item: _products.first,
          onItemChanged: (item) => setState(
            () => _products
              ..clear()
              ..add(item),
          ),
        ),
      ];

  List<Widget> _bPaymentRow() => [
        HeaderAndEditContainer(title: 'payment'.tr),
        Container(
          width: width,
          height: height * 0.07,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: width * 0.08),
          child: PaymentOptionsRow(onChoose: (paymentMethods) {}),
        ),
      ];
  List<Widget> _bDiscoutCoupon() => <Widget>[
        HeaderAndEditContainer(title: 'add_discount_coupon'.tr),
        InkWell(
          onTap: () async {
            final coupon = await Q.dialog(CouponDialog());
            if (coupon != null) {
              _discountCoupon = coupon;
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08, vertical: 10),
            child: Column(
              children: <Widget>[
                Text(
                  ' + ${'discount_coupon'.tr}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_discountCoupon != null)
                  Text(
                    _discountCoupon!.value.toString() + " " + 'rs'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ];

  Widget _bPickLocation() => ListTile(
        onTap: () async {
          final result = await Q.to<pp.LocationResult>(pp.PlacePicker(
            kMapsApiKey,
            // displayLocation: BlocProvider.of<CurrentLocationCubit>(context).currentLatLang,
          ));
          // Q.back();
          if (result?.latLng?.latitude != null &&
              result?.latLng?.latitude != null) {
            setState(() => _pickLocation = result);
          }
        },
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          radius: 17,
          child: Icon(CupertinoIcons.flag, size: 17),
        ),
        title: Text(
          'pickup_point'.tr,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        subtitle: Text(
          _pickLocation?.formattedAddress ?? 'choose_pickup_point'.tr,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('choose_loction'.tr,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.darkGreenAccent)),
            const Icon(Icons.chevron_right),
          ],
        ),
      );

  Widget _bDropLocation() {
    final data = _dropLocation?.formattedAddress ?? 'choose_drop_location'.tr;
    return ListTile(
      onTap: () async {
        final result = await Q.to<pp.LocationResult>(pp.PlacePicker(
          kMapsApiKey,
          // displayLocation: BlocProvider.of<CurrentLocationCubit>(context).currentLatLang,
        ));
        // Q.back();
        if (result?.latLng?.latitude != null &&
            result?.latLng?.longitude != null) {
          setState(() => _dropLocation = result);
        }
      },
      leading: const CircleAvatar(
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        radius: 17,
        child: Icon(CupertinoIcons.cube_box, size: 17),
      ),
      title: Text(
        'drop_location'.tr,
        style: const TextStyle(fontSize: 13, color: Colors.black54),
      ),
      subtitle: Text(
        data,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('choose_loction'.tr,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.darkGreenAccent)),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

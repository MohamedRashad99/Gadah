import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/models/shared/places/palce_details.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/helpers/auth.dart';
import 'package:gadha/helpers/url_lancher.dart';
import 'package:gadha/modules/client/coupon/dialog.dart';

import 'package:gadha/modules/client/make_order/views/order_drop_place_type_picker.dart';
import 'package:gadha/modules/client/make_order/views/order_items/view.dart';
import 'package:gadha/modules/client/orders/cubit/user_offers_cubit.dart';
import 'package:gadha/modules/shared/sucess.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/signle/header_edit_container.dart';
import 'package:place_picker/place_picker.dart' as pp;
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'cubit/make_order_cubit.dart';
import 'views/order_items/cubit/order_items_cubit.dart';
import 'views/payment_methods_row.dart';

class MakeOrderPage extends StatelessWidget {
  final PlaceDetailsEntity place;
  final String? coverImageUrl;

  const MakeOrderPage({required this.place, this.coverImageUrl, Key? key})
      : super(key: key);

  Widget _buildAppBar() {
    return Material(
      color: Colors.transparent,
      child: StanderedAppBar(
        appBarType: AppBarType.navigator,
        centerChild: ShowMoreText(
          place.name,
          maxLength: 33,
          showMoreText: '',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailingActions: <Widget>[
          InkWell(
            onTap: () => UrlLuncher.open(place.url),
            child: const Icon(
              FontAwesomeIcons.shareAlt,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => OrderItemsCubit()),
          BlocProvider(
            create: (_) => MakeOrderCubit(
              BlocProvider.of<OrderItemsCubit>(_),
              place,
              UserOrdersCubit.of(_),
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            final ordersCubit = BlocProvider.of<MakeOrderCubit>(context);
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: const StanderedAppBar(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: _buildFloatingActionBottons(
                    BlocProvider.of<MakeOrderCubit>(context)),
                body: Column(
                  children: <Widget>[
                    _buildAppBar(),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      width: width,
                      child: GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              HeaderAndEditContainer(
                                  title: 'products_to_buy'.tr),
                              const OrderItems(),
                              HeaderAndEditContainer(title: 'payment'.tr),
                              PaymentOptionsRow(
                                onChoose: (paymentMethods) {},
                              ),
                              HeaderAndEditContainer(title: 'drop_location'.tr),
                              OrderDropPlacePicker(
                                onTypeChange: (deliverToHome) {
                                  ordersCubit.dropToHome = deliverToHome;
                                },
                              ),
                              InkWell(
                                onTap: () async {
                                  final coupon = await Q.dialog(CouponDialog());
                                  if (coupon != null) {
                                    ordersCubit.coupon = coupon;
                                  }
                                },
                                child: Column(
                                  children: <Widget>[
                                    HeaderAndEditContainer(
                                        title: 'add_discount_coupon'.tr),
                                    InkWell(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.08,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  '\t+\t${'discount_coupon'.tr}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                            BlocBuilder<MakeOrderCubit,
                                                MakeOrderState>(
                                              builder: (i, st) {
                                                return Row(
                                                  children: <Widget>[
                                                    if (ordersCubit.coupon !=
                                                        null)
                                                      Text(
                                                        "${'you_have_discount'.tr}  ${ordersCubit.coupon!.value} ${'rs'.tr}",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    const Spacer(),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildFloatingActionBottons(MakeOrderCubit ordersCubit) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            size.width * 0.1, 0, size.width * 0.1, size.height * 0.01),
        child: SizedBox(
          width: size.width * 0.8,
          child: FloatingActionButton(
            isExtended: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            child: CustomMainButton(
              dropShadow: true,
              onTap: () async {
                try {
                  if (!AuthService.isLoggedIn) {
                    ifIsNotLoggedInAskElseAct(() {});
                    return;
                  } else if (ordersCubit.orderItemsCubit.items.isEmpty) {
                    throw 'must_enter_order_items'.tr;
                  }
                  for (final item in ordersCubit.orderItemsCubit.items) {
                    if (item.name.trim().isEmpty) {
                      // Q.alertWithSuccess('is empty');
                      throw 'products_names_must_not_be_empty'.tr;
                    } else {
                      // Q.alertWithSuccess('is not empty');
                    }
                  }
                  if (ordersCubit.dropToHome) {
                    Q.alertWithSuccess('plase_wait'.tr);
                    await ordersCubit.makeOrderToHome();
                    Q.to(const OrderSubmitted());
                  } else {
                    final result = await Q
                        .to<pp.LocationResult>(pp.PlacePicker(kMapsApiKey));
                    Q.alertWithSuccess('plase_wait'.tr);
                    if (result?.latLng?.latitude != null &&
                        result?.latLng?.longitude != null) {
                      ordersCubit.locationResult = result;
                      log('i will make new order to ${result?.latLng?.latitude}');
                      await ordersCubit.makeOrder();
                      Q.to(const OrderSubmitted());
                    }
                  }
                } catch (e) {
                  Q.alertWithErr(e.toString().tr);
                  log(e.toString());
                }
              },
              text: 'complete_your_order'.tr,
              borderRaduis: 25,
              textSize: 16,
              fontWeight: FontWeight.bold,
              height: size.height * 0.06,
            ),
          ),
        ),
      ),
    );
  }
}

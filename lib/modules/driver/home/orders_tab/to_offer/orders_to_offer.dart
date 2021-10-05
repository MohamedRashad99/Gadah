import 'package:flutter/material.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/modules/driver/orders_details_screen.dart';
import 'package:gadha/modules/shared/curren_location/cubit/current_location_cubit.dart';
import 'package:gadha/widgets/items/order_to_offer.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'cubit/orders_to_offer_cubit.dart';

class OrdersToOffer extends StatelessWidget {
  const OrdersToOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersToOfferCubit, OrdersToOfferState>(
      builder: (context, state) {
        if (state is OrdersToOfferError) {
          return CenterError(
            message: state.msg,
            buttonText: 'refresh'.tr,
            callback: OrdersToOfferCubit.of(context).refresh,
          );
        } else if (state is OrdersToOfferLoading) {
          return const CenterLoading();
        } else if (state is OrdersToOfferLoaded) {
          final _currentlocation =
              BlocProvider.of<CurrentLocationCubit>(context).currentLocation;
          return _currentlocation == null
              ? CenterError(
                  message: 'empty'.tr,
                  buttonText: 'refresh'.tr,
                  callback: OrdersToOfferCubit.of(context).refresh,
                )
              : buildItems(state.orders, context: context);
        } else if (state is OrdersToOfferLoadingMore) {
          return buildItems(state.orders,
              context: context, isLoadingMore: true);
        } else if (state is OrdersToOfferEmpty) {
          return CenterError(
            message: 'empty'.tr,
            buttonText: 'refresh'.tr,
            callback: OrdersToOfferCubit.of(context).refresh,
          );
        }
        return const SizedBox();
      },
    );
  }
}

Widget buildItems(
  List<OrderEntity> orders, {
  required BuildContext context,
  bool isLoadingMore = false,
}) {
  return RefreshIndicator(
    onRefresh: OrdersToOfferCubit.of(context).refresh,
    child: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, int index) {
        final cubit = OrdersToOfferCubit.of(context);

        final item = orders[index];
        final itemWidget = OrderItemToOffer(
          onTap: () => Q.to(DriverOrderDetails(item)),
          order: item,
        );
        final isLastItem = orders.length == index + 1;

        if (isLastItem && cubit.canLoadMore && !isLoadingMore) {
          cubit.loadMore();
        }
        if (isLastItem && isLoadingMore) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              itemWidget,
              const CenterLoading(),
            ],
          );
        } else {
          return itemWidget;
        }
      },
    ),
  );
}

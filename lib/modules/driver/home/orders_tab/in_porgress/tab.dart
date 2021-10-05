import 'package:flutter/material.dart';

import 'package:gadha/comman/models/order.dart';

import 'package:gadha/modules/driver/home/orders_tab/in_porgress/cubit/orders_in_progress_cubit.dart';
import 'package:gadha/modules/shared/chat/page.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'item.dart';

class OrdersInProgress extends StatelessWidget {
  const OrdersInProgress({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Center(
    // child: Text(AuthService.currentUser!.id.toString()));
    return BlocBuilder<OrdersInProgressCubit, OrdersInProgressState>(
      builder: (context, state) {
        if (state is OrdersInProgressError) {
          return CenterError(
            icon: Icons.error,
            message: state.msg,
            callback: OrdersInProgressCubit.of(context).refresh,
          );
        } else if (state is OrdersInProgressLoading) {
          return const CenterLoading();
        } else if (state is OrdersInProgressLoaded) {
          return buildItems(state.orders, context: context);
        } else if (state is OrdersInProgressLoadingMore) {
          return buildItems(state.orders,
              context: context, isLoadingMore: true);
        } else if (state is OrdersInProgressEmpty) {
          return CenterError(
            message: 'empty'.tr,
            buttonText: 'refresh'.tr,
            callback: OrdersInProgressCubit.of(context).refresh,
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
    onRefresh: OrdersInProgressCubit.of(context).refresh,
    child: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, int index) {
        final cubit = OrdersInProgressCubit.of(context);

        final item = orders[index];
        final itemWidget = OrderItemInProgress(
          order: item,
          onTap: () => Q.to(ChatPage(item)),
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

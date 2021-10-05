import 'package:flutter/material.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/widgets/items/old_order.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'cubit/orders_done_cubit.dart';

class OrdersDone extends StatelessWidget {
  const OrdersDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersDoneCubit, OrdersDoneState>(
      builder: (context, state) {
        if (state is OrdersDoneError) {
          return CenterError(
            icon: Icons.error,
            message: state.msg,
            callback: OrdersDoneCubit.of(context).refresh,
          );
        } else if (state is OrdersDoneLoading) {
          return const CenterLoading();
        } else if (state is OrdersDoneLoaded) {
          return buildItems(state.orders, context: context);
        } else if (state is OrdersDoneLoadingMore) {
          return buildItems(state.orders,
              context: context, isLoadingMore: true);
        } else if (state is OrdersDoneEmpty) {
          return CenterError(message: 'empty'.tr);
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
    onRefresh: OrdersDoneCubit.of(context).refresh,
    child: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, int index) {
        final cubit = OrdersDoneCubit.of(context);

        final item = orders[index];
        final itemWidget = OldOrderItem(order: item);
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

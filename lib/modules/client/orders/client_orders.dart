import 'package:flutter/material.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'cubit/user_offers_cubit.dart';
import 'order_item.dart';

class ClientOrders extends StatelessWidget {
  const ClientOrders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: BlocBuilder<UserOrdersCubit, UserOrdersState>(
            builder: (context, state) {
              if (state is UserOrdersError) {
                return CenterError.err(
                  state.msg,
                  callback: UserOrdersCubit.of(context).refresh,
                );
              } else if (state is UserOrdersLoading) {
                return const CenterLoading();
              } else if (state is UserOrdersLoaded) {
                return buildItems(orders: state.orders, context: context);
              } else if (state is UserOrdersIsEmpty) {
                return CenterError(
                  message: 'empty'.tr,
                  callback: UserOrdersCubit.of(context).refresh,
                );
              }
              return const SizedBox();
            },
          ),
        ),
        Container(color: Colors.white, width: width, height: height * 0.06),
      ],
    );
  }
}

Widget _buildAppBar() {
  return Material(
    color: Colors.transparent,
    child: StanderedAppBar(
      appBarType: AppBarType.navigator,
      leading: Container(),
      centerChild: Text(
        'your_orders'.tr,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          // fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildItems({
  required List<OrderEntity> orders,
  required BuildContext context,
}) {
  return RefreshIndicator(
    onRefresh: UserOrdersCubit.of(context).refresh,
    child: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, int index) => OrderItem(orders[index]),
    ),
  );
}



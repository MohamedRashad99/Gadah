import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadha/modules/client/make_order/views/order_items/cubit/order_items_cubit.dart';
import 'package:gadha/widgets/items/cart_item.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = OrderItemsCubit.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: BlocBuilder<OrderItemsCubit, OrderItemsState>(
        builder: (_, state) {
          if (state is OrderItemsLoaded) {
            return Column(
              children: <Widget>[
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: state.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      color: index.isEven ? Colors.grey[100] : Colors.grey[200],
                      child: CartItemWidget(
                        item: state.items[index],
                        onDismissed: (_) => cubit.deleteAt(index),
                        onItemChanged: (product) =>
                            cubit.updateAt(index, product),
                      ),
                    );
                  },
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: cubit.addItem,
                  icon: const Icon(Icons.add, size: 16),
                  label: Text("write_your_order".tr,
                      style: const TextStyle(fontSize: 13)),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

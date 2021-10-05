import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:get/get.dart';

class OrderProducts extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderProducts(this.orderEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('products'.tr),
        centerTitle: true,
        backgroundColor: AppColors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: orderEntity.products!.length,
        itemBuilder: (_, i) {
          final prod = orderEntity.products![i];
          return Card(
            child: prod.image == null
                ? ListTile(
                    leading: Text(prod.quantity.toString()),
                    title: Text(prod.name),
                  )
                : ExpansionTile(
                    leading: Text(prod.quantity.toString()),
                    title: Text(prod.name),
                    children: [Image.network(fullImagePath(prod.image))],
                  ),
          );
        },
      ),
    );
  }
}

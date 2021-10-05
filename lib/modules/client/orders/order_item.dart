import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/location_services.dart';
import 'package:gadha/modules/client/order_offers/page.dart';
import 'package:gadha/modules/shared/chat/page.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

class OrderItem extends StatelessWidget {
  final OrderEntity order;

  const OrderItem(this.order, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => order.awaiting
            ? Q.to(ClientOrderOfferTab(order))
            : Q.to(ChatPage(order)),
        title: Text(order.place.name),
        subtitle: Text(
            '${order.products!.first.name}${order.products!.length >= 2 ? ', ${order.products![1].name}' : ''} ....'),
        leading: CircleAvatar(
          backgroundColor: AppColors.lightBlue,
          child: Text(order.id.toString()),
        ),
        trailing: Text(geatStoreDistance(context)),
      ),
    );
  }

  String geatStoreDistance(BuildContext context) {
    final distance = LocationServices.instance.getDistanceBetwwen(
      double.tryParse(order.place.latitude) ?? 0,
      double.tryParse(order.place.longtude) ?? 0,
      double.tryParse(order.dropPlace.latitude) ?? 0,
      double.tryParse(order.dropPlace.longtude) ?? 0,
    );
    return distanceToString(distance);
  }

  String distanceToString(num distance) {
    // return distance.toInt().toString();
    if (distance >= 1) {
      return '${distance.toStringAsPrecision(3)} ${'km'.tr}';
    } else {
      return '${(distance * 1000).toInt()} ${'meter'.tr}';
    }
  }
}

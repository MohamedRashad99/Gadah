import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/modules/shared/curren_location/cubit/current_location_cubit.dart';
import 'package:gadha/comman/services/location_services.dart';
import 'package:gadha/widgets/items/order_list_tile.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

Widget _iconAboveText(String text, IconData icon) {
  return Column(
    children: [
      Icon(
        icon,
        color: AppColors.lightBlueAccent,
      ),
      Text(text.tr, style: textTheme.caption),
    ],
  );
}

class OrderItemToOffer extends StatelessWidget {
  final VoidCallback onTap;
  final OrderEntity order;

  const OrderItemToOffer({required this.onTap, required this.order, Key? key})
      : super(key: key);

  String getDistanceFromMeToPickLocation(BuildContext context) {
    final currentDriverLocation =
        BlocProvider.of<CurrentLocationCubit>(context).currentLocation!;
    final distance = LocationServices.instance
        .getDistanceBetwwen(
          currentDriverLocation.latitude!,
          currentDriverLocation.longitude!,
          double.tryParse(order.place.latitude) ?? 0,
          double.tryParse(order.place.longtude) ?? 0,
        )
        .toInt();
    return distanceToString(distance);
  }

  String getDistanceFromMeToDropLocation(BuildContext context) {
    final currentDriverLocation =
        BlocProvider.of<CurrentLocationCubit>(context).currentLocation!;
    final distance = LocationServices.instance.getDistanceBetwwen(
      currentDriverLocation.latitude!,
      currentDriverLocation.longitude!,
      double.tryParse(order.dropPlace.latitude) ?? 0,
      double.tryParse(order.dropPlace.longtude) ?? 0,
    );
    return distanceToString(distance);
  }

  String distanceToString(num distance) {
    if (distance > 1000) {
      return '${distance ~/ 1000} ${'km'.tr}';
    } else {
      return '${distance.toInt()} ${'meter'.tr}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _drArrow = Icon(
      currentTextDirection != TextDirection.rtl
          ? Icons.arrow_right
          : Icons.arrow_left,
    );
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            ListTile(
              trailing: Text(
                '#${order.id}',
                style: const TextStyle(
                  color: AppColors.darkGreen,
                  fontSize: 14,
                ),
              ),
              title: ListTileIconRow(
                title: order.place.name,
                icon: FontAwesomeIcons.store,
                isBold: true,
              ),
              subtitle: ListTileIconRow(
                title: '${order.products!.first.name}...',
                icon: FontAwesomeIcons.cartPlus,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _iconAboveText('you', Icons.person),
                _drArrow,
                Text(
                  getDistanceFromMeToPickLocation(context),
                ),
                _drArrow,
                _iconAboveText('pick_location', FontAwesomeIcons.shopify),
                _drArrow,
                Text(getDistanceFromMeToDropLocation(context)),
                _drArrow,
                _iconAboveText('drop_location', Icons.flag),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/offer.dart';
import 'package:gadha/comman/services/location_services.dart';
import 'package:gadha/modules/client/order_offers/confirm_offer_dialog.dart';

import 'package:gadha/modules/shared/curren_location/cubit/current_location_cubit.dart';
import 'package:gadha/modules/shared/my_reviews/page.dart';
import 'package:gadha/widgets/buttons/custom_main_button.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OfferItem extends StatelessWidget {
  final OfferEntity offer;
  final int orderId;
  const OfferItem(this.offer, this.orderId, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () => Q.to(UserReviewsScreen(offer.driver)),
            leading: offer.driver.image == null
                ? null
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(fullImagePath(offer.driver.image))),
            title: Text(offer.driver.name),
            subtitle: Row(
              children: [
                Directionality(
                  textDirection: directionReversed,
                  child: SmoothStarRating(
                    allowHalfRating: false,
                    onRated: (v) {},
                    rating: offer.driver.stars.toDouble(),
                    size: 14.0,
                    isReadOnly: true,
                    color: Colors.amber,
                    borderColor: Colors.grey[300]!,
                  ),
                ),
                Text(offer.driver.stars.toString()),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item('far_from',
                  '${getDistanceFromMeToDriver(context)}  ${'km'.tr}'),
              const Text('|'),
              _item('price', '${offer.price}   ${'rs'.tr}'),
              const Text('|'),
              _buildAcceptBoottoun(context)
            ],
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }

  String getDistanceFromMeToDriver(BuildContext context) {
    final currentDriverLocation =
        BlocProvider.of<CurrentLocationCubit>(context).currentLocation!;
    final distance = LocationServices.instance.getDistanceBetwwen(
      currentDriverLocation.latitude!,
      currentDriverLocation.longitude!,
      double.tryParse(offer.driver.lattitude ?? '') ?? 0,
      double.tryParse(offer.driver.langtude ?? '') ?? 0,
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

  Widget _item(String title, String content) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(content),
        Text(title.tr),
      ],
    );
  }

  Widget _buildAcceptBoottoun(BuildContext context) {
    return SizedBox(
      child: CustomMainButton(
        width: size.width * .25,
        dropShadow: true,
        onTap: () => Q.dialog(ConfirmOfferDialog(offer, orderId)),
        text: 'accept'.tr,
        borderRaduis: 25,
        textSize: 16,
        fontWeight: FontWeight.bold,
        height: size.height * 0.06,
      ),
    );
  }
}

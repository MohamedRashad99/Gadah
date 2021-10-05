import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

import 'order_list_tile.dart';

class UserOrderItem extends StatelessWidget {
  final String? status;
  final String? updateTime;
  final String? location;
  final String? placeImagePath;
  final String? placeName;
  final num? orderID;
  final String? orderPlaceDistance;
  final num? totalPrice;
  final String? placeAddress;
  final int? statusIndex;

  const UserOrderItem({
    Key? key,
    this.status,
    this.updateTime,
    this.location,
    this.orderPlaceDistance,
    this.placeImagePath,
    this.orderID,
    this.placeName,
    this.totalPrice,
    this.placeAddress,
    this.statusIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _colorsList = [
      AppColors.palehDarkGreen,
      AppColors.darkGreenAccent,
      AppColors.darkBlue,
      Colors.deepPurpleAccent,
    ];
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.19 * 0.95,
      width: size.width,
      margin: EdgeInsets.only(bottom: size.height * 0.025),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black12, spreadRadius: 0.1, blurRadius: 5)
      ]),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned.fill(
              bottom: null,
              child: Container(
                width: size.width,
                height: size.height * 0.08 * 0.90,
                decoration: BoxDecoration(
                  color: _colorsList[statusIndex!],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(updateTime!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11)),
                        Text(status!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: null,
              child: Container(
                width: size.width,
                height: size.height * 0.15 * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: OrderListTile(
                    leading: Container(
                      width: size.width * 0.18,
                      height: size.width * 0.18,
                      decoration: const BoxDecoration(
                        color: AppColors.darkWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      // padding: Ed,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FancyShimmerImage(
                          imageUrl: kStoreUrl,
                          shimmerBaseColor: Colors.grey[300],
                          shimmerHighlightColor: Colors.grey[100],
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(
                          // right:.tr.isArabic ? 15 : 0,
                          // left:.tr.isArabic ? 0 : 15,
                          ),
                      child: ListTileIconRow(
                        title: placeName ?? '',
                        icon: FontAwesomeIcons.store,
                        isBold: true,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                          // right:.tr.isArabic ? 15 : 0,
                          // left:.tr.isArabic ? 0 : 15,
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (totalPrice != null)
                            ListTileIconRow(
                              title: '${totalPrice.toString()} ${'rs'.tr}',
                              icon: FontAwesomeIcons.moneyBillAlt,
                            )
                          else
                            ListTileIconRow(
                              title: placeAddress,
                              icon: FontAwesomeIcons.mapMarkerAlt,
                            ),
                        ],
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '#${orderID?.toString()}',
                            style: const TextStyle(
                              color: AppColors.darkGreen,
                              fontSize: 10,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                orderPlaceDistance!,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                  color: AppColors.boldBlack,
                                  fontSize: 14 * 0.8,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: AppColors.darkGreen,
                                size: 17 * .8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

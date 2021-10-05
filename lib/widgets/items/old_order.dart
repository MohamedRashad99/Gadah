import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/widgets/items/order_list_tile.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

class OldOrderItem extends StatelessWidget {
  final OrderEntity order;
  const OldOrderItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.18 * 0.95,
      width: size.width,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned.fill(
              bottom: null,
              child: Container(
                width: size.width,
                height: size.height * 0.08 * 0.9,
                decoration: BoxDecoration(
                  // color: _colorsList[statusIndex!],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: const <Widget>[
                    //     // Text(order.!, style: const TextStyle(fontSize: 11, color: Colors.white)),
                    //     // Text(status!, style: const TextStyle(fontSize: 11, color: Colors.white)),
                    //   ],
                    // ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: null,
              child: Container(
                height: size.height * 0.19,
                width: size.width,
                // margin: EdgeInsets.only(bottom: size.height * 0.025),
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 0.1, blurRadius: 5)
                ]),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: OrderListTile(
                        leading: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          decoration: const BoxDecoration(
                            color: AppColors.darkWhite,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.1,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99.0),
                            child: FancyShimmerImage(
                              imageUrl: kStoreUrl,
                              shimmerBaseColor: Colors.grey[300],
                              shimmerHighlightColor: Colors.grey[100],
                              boxFit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: EdgeInsets.only(
                            right: isArabic ? 15 : 0,
                            left: isArabic ? 0 : 15,
                          ),
                          child: ListTileIconRow(
                            title: order.place.name,
                            icon: FontAwesomeIcons.store,
                            isBold: true,
                          ),
                        ),
                        // subtitle: Padding(
                        //   padding: EdgeInsets.only(
                        //     right: isArabic ? 15 : 5,
                        //     left: isArabic ? 5 : 15,
                        //   ),
                        //   child: ListTileIconRow(
                        //     title: order.owner.,
                        //     maxLength: 60,
                        //     icon: FontAwesomeIcons.mapMarkedAlt,
                        //   ),
                        // ),
                        trailing: Text(
                          '#${order.id}',
                          style: const TextStyle(
                            color: AppColors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        //   bottom: Padding(
                        //     padding: const EdgeInsets.only(top: 20.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: List.generate(_buildDistanceRow.length, (index) {
                        //         final buildDistanceRow = _buildDistanceRow[index];
                        //         final _expanded = Expanded(child: buildDistanceRow);
                        //         if (index.isOdd) return _expanded;
                        //         return buildDistanceRow;
                        //       }),
                        //     ),
                        //   ),
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/shared/places/palce_details.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ServiceShopDetails extends StatelessWidget {
  final PlaceDetailsEntity? placeDetails;

  const ServiceShopDetails({Key? key, this.placeDetails}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   _detailsString,
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 10,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: <Widget>[
              const FaIcon(
                FontAwesomeIcons.phone,
                color: AppColors.lightGreenAccent3,
                size: 13,
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  if (placeDetails!.internationalPhoneNumber != null) {
                    final phoneNumber =
                        'tel://${placeDetails!.internationalPhoneNumber}';
                    try {
                      if (await url_launcher.canLaunch(phoneNumber)) {
                        await url_launcher.launch(phoneNumber);
                      } else {
                        throw 'ERROR ';
                      }
                    } catch (e) {
                      log(e.toString());
                    }
                  }
                },
                child: Text(
                  placeDetails!.internationalPhoneNumber ??
                      "phone_number_isn't_available".tr,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const FaIcon(
                FontAwesomeIcons.locationArrow,
                color: AppColors.lightGreenAccent3,
                size: 13,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  placeDetails!.formattedAaddress!,
                  textAlign: TextAlign.start,
                  textDirection: currentTextDirection,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/models/shared/places/palce_details.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class ServiceShopReviews extends StatelessWidget {
  final GMapPlaceReviewEntity? review;
  final VoidCallback? onTap;
  const ServiceShopReviews({this.review, this.onTap, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: review?.profilePhotoUrl != null
                  ? FancyShimmerImage(
                      imageUrl: review!.profilePhotoUrl,
                      width: 40,
                      height: 40,
                    )
                  : CircleAvatar(
                      child: review?.profilePhotoUrl == null
                          ? const FaIcon(FontAwesomeIcons.user)
                          : null,
                    ),
              title: Text(
                review!.authorName,
                style: const TextStyle(
                  color: AppColors.boldBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Row(
                children: <Widget>[
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (_) {},
                      rating: review!.rating.toDouble(),
                      size: 15.0,
                      isReadOnly: true,
                      color: Colors.amber,
                      borderColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(review!.relativeTimeDescription,
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Text(
                review!.text,
                style: const TextStyle(
                  color: AppColors.boldBlack,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

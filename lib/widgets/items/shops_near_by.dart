import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/modules/client/place_profile/page.dart';
import 'package:queen/queen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// reting: place.rating,
// title: place.name,
// imageUrl: place.icon,
class NearByShop extends StatelessWidget {
  final PlaceEntity place;
  const NearByShop(this.place, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.fromLTRB(10, 8, 10, 8);
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Q.to(ServiceShopProfile(place: place)),
      child: Container(
        width: size.width * 0.35,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.2,
              blurRadius: 5,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              // textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                FancyShimmerImage(
                  imageUrl: place.icon ?? '',
                  width: 30,
                  height: 30,
                  shimmerBaseColor: Colors.grey[300],
                  shimmerHighlightColor: Colors.grey[100],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            place.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: AppColors.boldBlackAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      if (place.rating != null)
                        Expanded(
                          child: Directionality(
                            textDirection: directionReversed,
                            child: SmoothStarRating(
                              allowHalfRating: false,
                              onRated: (v) {},
                              rating: place.rating!.toDouble(),
                              size: 13.0,
                              isReadOnly: true,
                              color: Colors.amber,
                              borderColor: Colors.grey[300]!,
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

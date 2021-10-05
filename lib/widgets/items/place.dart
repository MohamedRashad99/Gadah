import 'package:flutter/material.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PlaceWidget extends StatelessWidget {
  final PlaceEntity place;
  final ValueChanged<PlaceEntity> onPress;
  const PlaceWidget(this.place, {required this.onPress, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(place.name, style: textTheme.headline6),
            SizedBox(height: height * .01),
            if (place.photos != null && place.photos!.isNotEmpty)
              SizedBox(
                height: height * .08,
                child: ListView.builder(
                  itemCount: place.photos!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () => Q.dialog(
                        Center(
                          child: Image.network(
                            fullPlaceImagePath(place.photos![i]),
                          ),
                        ),
                      ),
                      child: Image.network(
                        fullPlaceImagePath(place.photos![i]),
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: height * .01),
            if (place.rating != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(place.rating!.toString(), style: textTheme.headline6),
                  SizedBox(width: width * .02),
                  Directionality(
                    textDirection: directionReversed,
                    child: SmoothStarRating(
                      rating: double.tryParse(place.rating!.toString()) ?? 0,
                      size: 19.0,
                      isReadOnly: true,
                      color: Colors.amber,
                      borderColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: width * .02),
                  Text('( ${place.userRatingsTotal.toString()} ${'rate'.tr})'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

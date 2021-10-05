import 'package:flutter/material.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/review.dart';
import 'package:queen/queen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewModel;

  const ReviewWidget(
    this.reviewModel, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _reviewHasImage = reviewModel.reviewer.image != null;
    return Card(
      child: ExpansionTile(
        leading: !_reviewHasImage
            ? null
            : CircleAvatar(
                backgroundImage: NetworkImage(
                  fullImagePath(reviewModel.reviewer.image),
                ),
              ),
        title: Text(
          reviewModel.reviewer.name,
          style: theme.textTheme.headline6,
        ),
        trailing: Directionality(
          textDirection: directionReversed,
          child: SmoothStarRating(
            allowHalfRating: false,
            onRated: (v) {},
            rating: reviewModel.stars.toDouble(),
            size: 14.0,
            isReadOnly: true,
            color: Colors.amber,
            borderColor: Colors.grey[300]!,
          ),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reviewModel.comment, style: theme.textTheme.bodyText1),
        ],
      ),
    );
  }
}

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/shared/places/palce_details.dart';
import 'package:gadha/modules/client/place_profile/cubit/place_profile_cubit.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:gadha/widgets/shop_details.dart';
import 'package:gadha/widgets/items/shop_reviews.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceProfileBody extends StatelessWidget {
  final String? coverImageUrl;

  const PlaceProfileBody({this.coverImageUrl, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PlaceProfileCubit, PlaceProfileState>(
        builder: (context, state) {
          if (state is PlaceProfileLoading) {
            return SizedBox(
              width: size.width,
              height: size.height * (1 - 0.063),
              child: const CenterLoading(),
            );
          } else if (state is PlaceProfileCant) {
            return CenterError(
                icon: FontAwesomeIcons.sadCry, message: 'error_happened'.tr);
          } else if (state is PlaceProfileLoaded) {
            return ListView(
              padding: EdgeInsets.only(bottom: size.height * 0.1),
              children: [
                _buildServiceWallpaper(state.place),
                _buildShopQuickSummery(state.place),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.60,
                  child: DefaultTabController(
                    initialIndex: !isArabic ? 1 : 0,
                    length: 2,
                    child: _buildDetailsTap(state.place),
                  ),
                )
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildServiceWallpaper(PlaceDetailsEntity placeDetails) {
    return Container(
      height: height * 0.25,
      width: width,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: coverImageUrl?.contains('svg') ?? false
                ? SvgPicture.network(coverImageUrl!, fit: BoxFit.cover)
                : FancyShimmerImage(
                    imageUrl: coverImageUrl ?? kStoreUrl,
                    boxFit: BoxFit.cover,
                    shimmerBaseColor: Colors.grey[300],
                    shimmerHighlightColor: Colors.grey[100],
                  ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 1],
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(1),
                  ],
                ).createShader(
                  Rect.fromLTRB(
                    0,
                    -120,
                    rect.width,
                    rect.height,
                  ),
                );
              },
              blendMode: BlendMode.srcIn,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopQuickSummery(PlaceDetailsEntity place) {
    return Align(
      alignment: const Alignment(0, -0.55),
      child: PlayAnimation<double>(
        tween: Tween<double>(begin: 0.0, end: 1),
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 400),
        builder: (context, child, value) {
          final valueRev = 1 - value;
          return Transform.translate(
            offset: Offset(size.width * valueRev, 0),
            child: child,
          );
        },
        child: Container(
          height: size.height * 0.17,
          width: size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10),
            ],
          ),
          padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.010,
              size.width * 0.1, size.height * 0.012),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FancyShimmerImage(
                          imageUrl: place.icon!, height: 25, width: 25),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: size.height * 0.17 * 0.20,
                        width: size.width * 0.85,
                        child: Center(
                          child: Text(
                            place.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        place.formattedAaddress ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            (place.rating == null || place.rating == 0.0)
                                ? 'empty'.tr
                                : place.rating.toString(),
                            style: const TextStyle(
                              color: AppColors.boldBlack,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            FontAwesomeIcons.solidStar,
                            color: AppColors.lightGreenAccent3,
                            size: 17 * 0.9,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor:
                                place.businessStatus != 'OPERATIONAL'
                                    ? AppColors.boldBlackAccent
                                    : AppColors.lightGreenAccent3,
                            radius: 5,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            place.businessStatus != 'OPERATIONAL'
                                ? 'closed'.tr
                                : 'open'.tr,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // _LoactionDistanceViewer(result: place),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReveiwsListView(PlaceDetailsEntity place) {
    if (place.reviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: InkWell(
            onTap: () async {
              final url = place.url!;
              if (await canLaunch(url)) {
                await launch(url, statusBarBrightness: Brightness.light);
              } else {
                log('Could not launch $url');
              }
            },
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'no_reviews'.tr,
                    style: const TextStyle(
                      color: AppColors.lightGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${'be_first_reviewer'.tr} ${place.name}',
                    style: const TextStyle(
                      color: AppColors.boldBlackAccent,
                      // fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 50, top: 10),
        itemCount: place.reviews.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final review = place.reviews[index];
          return ServiceShopReviews(
            onTap: () async {
              final url = review.authorUrl;
              if (await canLaunch(url)) {
                await launch(url, statusBarBrightness: Brightness.light);
              } else {
                log('Could not launch $url');
              }
            },
            review: review,
          );
        },
      );
    }
  }

  Widget _buildDetailsTap(
    PlaceDetailsEntity placeDetails,
  ) {
    final myTabsPages = <Widget>[
      _buildReveiwsListView(placeDetails),
      ServiceShopDetails(
        key: const PageStorageKey('shop_details'),
        placeDetails: placeDetails,
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: TabBar(
            labelPadding: const EdgeInsets.symmetric(vertical: 12),
            indicatorColor: AppColors.boldBlack,
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: size.width * 0.05),
            indicatorWeight: 3,
            tabs: <Widget>[
              Text(
                'reviews'.tr,
                style:
                    const TextStyle(color: AppColors.boldBlack, fontSize: 11),
              ),
              Text(
                'details'.tr,
                style:
                    const TextStyle(color: AppColors.boldBlack, fontSize: 11),
              ),
            ],
          ),
        ),
        Expanded(child: TabBarView(children: myTabsPages))
      ],
    );
  }
}

// class _LoactionDistanceViewer extends StatefulWidget {
//   const _LoactionDistanceViewer({
//     Key? key,
//     required this.place,
//   }) : super(key: key);

//   final PlaceDetailsEntity place;

//   @override
//   __LoactionDistanceViewerState createState() => __LoactionDistanceViewerState();
// }

// class __LoactionDistanceViewerState extends State<_LoactionDistanceViewer> {
//   // LocationFuture? _currentLocaiton;
//   // @override
//   // void initState() {
//   //   WidgetsBinding.instance!.addPostFrameCallback((_) async {
//   //     _currentLocaiton = await LocationServices.getCoords();
//   //     if (mounted) setState(() {});
//   //   });
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final placeLatLng = widget.place.geometry!.location;
//     String gcd;
//     if (BlocProvider.of<CurrentLocationCubit>(context).currentLocation != null) {
//       gcd = LocationServices.calculateDistance(
//         oldLocation: BlocProvider.of<CurrentLocationCubit>(context).currentLocation!,
//         to: placeLatLng!,
//       ).toString();
//     } else {
//       gcd = 0.0.getDistance;
//     }
//     return Row(
//       children: <Widget>[
//         Text(
//           gcd,
//           textDirection: TextDirection.ltr,
//           style: const TextStyle(
//             color: AppColors.boldBlack,
//             fontSize: 11,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const Icon(
//           FontAwesomeIcons.mapMarkerAlt,
//           color: AppColors.lightGreenAccent3,
//           size: 17 * 0.9,
//         ),
//       ],
//     );
//   }
// }

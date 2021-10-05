import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/modules/client/place_profile/page.dart';
import 'package:gadha/modules/client/search/radius_filter.dart';
import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'cubit/near_by_search_cubit.dart';

class SearchPage extends StatelessWidget {
  final String? name;
  final String? type;
  final String? initalKeyWord;
  SearchPage({this.name, this.type, Key? key, this.initalKeyWord})
      : cubit = NearBySearchCubit(name: name, type: type),
        super(key: key) {
    if (initalKeyWord != null) {
      cubit.onKeywordChange(initalKeyWord!);
    }
  }
  final NearBySearchCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: const StanderedAppBar(),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  SizedBox(
                    width: size.width,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: Q.back,
                        ),
                        Expanded(child: _buildSearchTextField(context)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: BlocBuilder<NearBySearchCubit, NearBySearchState>(
                    builder: (context, state) {
                      if (state is NearBySearchLoading) {
                        return const CenterLoading();
                      } else if (state is NearBySearchEmpty) {
                        return CenterError(
                          message: 'empty'.tr,
                          callback: BlocProvider.of<NearBySearchCubit>(context)
                              .refresh,
                        );
                      } else if (state is NearBySearchCant) {
                        return CenterError.err(
                          state.msg.toLowerCase() == 'zero_results'
                              ? 'zero_results'.tr
                              : state.msg,
                          callback: BlocProvider.of<NearBySearchCubit>(context)
                              .refresh,
                        );
                      } else if (state is NearBySearchLoaded) {
                        return _buildResult(state.places);
                      } else if (state is NearBySearchLoadedMore) {
                        return _buildResult(state.places);
                      }
                      return const SizedBox();
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResult(List<PlaceEntity> places) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 30, bottom: 40),
      itemCount: places.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final place = places[index];
        return ListTile(
          onTap: () => Q.to(ServiceShopProfile(place: place)),
          leading: FancyShimmerImage(
            imageUrl: place.icon!,
            width: size.width * 0.08,
            height: size.width * 0.08,
            boxFit: BoxFit.cover,
            shimmerBaseColor: Colors.grey[300],
            shimmerHighlightColor: Colors.grey[100],
          ),
          title: Text(place.name),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  SizedBox(width: 5),
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: AppColors.fancyGreen,
                    size: 16,
                  ),
                ],
              ),
              Directionality(
                textDirection: directionReversed,
                child: SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  rating: (place.rating?.toDouble() ?? 0) * 1.0,
                  size: 14.0,
                  isReadOnly: true,
                  color: Colors.amber,
                  borderColor: Colors.grey[300]!,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchTextField(BuildContext context) {
    return Hero(
      tag: 'ValueKey(5)',
      child: Container(
        height: size.height * 0.050,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Theme(
          data: ThemeData(
            primaryColor: AppColors.lightBlack,
            primaryColorDark: AppColors.lightBlueAccent,
          ),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Material(
              child: TextField(
                style: const TextStyle(fontSize: 13),
                onChanged:
                    BlocProvider.of<NearBySearchCubit>(context).onKeywordChange,
                keyboardType: TextInputType.text,
                keyboardAppearance: Brightness.light,
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                  hintText: 'search'.tr,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.lightBlack,
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: const Icon(
                    FontAwesomeIcons.search,
                    size: 18,
                    color: AppColors.darkGreenAccent,
                  ),
                  focusColor: AppColors.lightBlack,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showModalBottomSheet<int>(
                            context: context,
                            builder: (_) => const SearchFilter(),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 1,
                                color: Colors.grey[300],
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                              ),
                              SvgPicture.asset(
                                Constants.searchFilter,
                                color: AppColors.darkGreenAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

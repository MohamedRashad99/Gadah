import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/models/review.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/modules/shared/my_reviews/cubit/my_reviews_cubit.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:gadha/widgets/signle/center_error.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

import 'package:shimmer/shimmer.dart';

import 'item.dart';

class UserReviewsScreen extends StatefulWidget {
  final User user;
  const UserReviewsScreen(this.user, {Key? key}) : super(key: key);

  @override
  _UserReviewsScreenState createState() => _UserReviewsScreenState();
}

class _UserReviewsScreenState extends State<UserReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserReviewsCubit(widget.user),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              StanderedAppBar(
                appBarType: AppBarType.navigatorExtended,
                centerChild: Text(
                  'reviews'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<UserReviewsCubit, UserReviewsState>(
                  builder: (context, state) {
                    if (state is UserReviewsLoading) {
                      return ListView.builder(
                        itemCount: 10,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: 20),
                        itemBuilder: (_, i) => _buildLoading(size),
                      );
                    } else if (state is UserReviewsEmpty) {
                      return CenterError(
                        icon: FontAwesomeIcons.star,
                        message: 'no_reviews'.tr,
                        callback: UserReviewsCubit.of(context).refresh,
                      );
                    } else if (state is UserReviewsLoadingMore) {
                      return buidContent(state.reviews, isLoadingMore: true);
                    } else if (state is UserReviewsLoaded) {
                      return buidContent(state.reviews);
                    } else if (state is UserReviewsCatLoad) {
                      return CenterError(
                        icon: FontAwesomeIcons.bellSlash,
                        message: state.msg,
                        callback: UserReviewsCubit.of(context).refresh,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buidContent(
    List<ReviewModel> reviews, {
    bool isLoadingMore = false,
  }) {
    return RefreshIndicator(
      onRefresh: () async => UserReviewsCubit.of(context).refresh(),
      child: ListView.builder(
          itemCount: reviews.length,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05)
              .add(const EdgeInsets.only(bottom: 30)),
          itemBuilder: (context, index) {
            final cubit = UserReviewsCubit.of(context);
            final item = reviews[index];
            final itemWidget = ReviewWidget(item);
            final isLastItem = reviews.length == index + 1;
            if (isLastItem && cubit.canLoadMore && !isLoadingMore) {
              cubit.loadMore();
            }
            if (isLastItem && isLoadingMore) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [itemWidget, const CenterLoading()],
              );
            }
            return itemWidget;
          }),
    );
  }

  Container _buildLoading(Size size) {
    return Container(
      height: height * 0.09,
      width: width * 0.95,
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: height * 0.09,
        width: width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              spreadRadius: 0.05,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            dense: false,
            leading: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const SizedBox(),
            ),
            title: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 50,
                  height: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            subtitle: SizedBox(
              width: size.width * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 20,
                    height: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            trailing: Container(
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/models/review.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/comman/services/reviews_repo.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'my_reviews_state.dart';

class UserReviewsCubit extends Cubit<UserReviewsState> {
  final User user;
  UserReviewsCubit(this.user) : super(UserReviewsLoading()) {
    refresh();
  }
  factory UserReviewsCubit.of(BuildContext context) =>
      BlocProvider.of<UserReviewsCubit>(context);

  final _reviews = <ReviewModel>[];
  var _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;
  var _pageNo = 0;

  void refresh() {
    _reviews.clear();
    _canLoadMore = true;
    _pageNo = 0;
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    emit(_reviews.isEmpty
        ? UserReviewsLoading()
        : UserReviewsLoadingMore(_reviews));
    try {
      final newReviews = await ReviewsRepo.finManyByUserId(user.id, ++_pageNo);
      _canLoadMore = newReviews.isNotEmpty;
      _reviews.addAll(newReviews);
      emit(_reviews.isEmpty ? UserReviewsEmpty() : UserReviewsLoaded(_reviews));
    } catch (e) {
      emit(UserReviewsCatLoad(e.toString()));
    }
  }
}

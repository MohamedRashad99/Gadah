part of 'my_reviews_cubit.dart';

@immutable
abstract class UserReviewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserReviewsLoading extends UserReviewsState {}

class UserReviewsEmpty extends UserReviewsState {}

class UserReviewsLoadingMore extends UserReviewsState {
  final List<ReviewModel> reviews;

  UserReviewsLoadingMore(this.reviews);
  @override
  List<Object?> get props => [reviews];
}

class UserReviewsLoaded extends UserReviewsState {
  final List<ReviewModel> reviews;

  UserReviewsLoaded(this.reviews);
  @override
  List<Object?> get props => [reviews];
}

class UserReviewsCatLoad extends UserReviewsState {
  final String msg;
  UserReviewsCatLoad(this.msg);
  @override
  List<Object?> get props => [msg];
}

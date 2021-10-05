part of 'user_offers_cubit.dart';

@immutable
abstract class UserOffersState extends Equatable {}

class UserOffersInitial extends UserOffersState {
  @override
  List<Object?> get props => [];
}

class UserOffersIsEmpty extends UserOffersState {
  @override
  List<Object?> get props => [];
}

class UserOffersLoaded extends UserOffersState {
  final List<OfferEntity> offers;

  UserOffersLoaded(
    this.offers,
  );

  @override
  List<Object?> get props => [
        offers,
      ];
}

class UserOffersError extends UserOffersState {
  final String msg;
  UserOffersError({
    required this.msg,
  });
  @override
  List<Object?> get props => [msg];
}

class UserOffersLoading extends UserOffersState {
  @override
  List<Object?> get props => [];
}

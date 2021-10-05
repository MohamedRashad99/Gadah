part of 'home_near_by_cubit.dart';

@immutable
abstract class HomeNearByState {}

class HomeNearByLoading extends HomeNearByState {}

class HomeNearByLoaded extends HomeNearByState {
  final List<PlaceEntity> places;

  HomeNearByLoaded(this.places);
}

class HomeNearByCant extends HomeNearByState {
  final String msg;

  HomeNearByCant(this.msg);
}

part of 'near_by_search_cubit.dart';

@immutable
abstract class NearBySearchState {}

class NearBySearchLoading extends NearBySearchState {}

class NearBySearchEmpty extends NearBySearchState {}

class NearBySearchCant extends NearBySearchState {
  final String msg;

  NearBySearchCant(this.msg);
}

class NearBySearchLoaded extends NearBySearchState {
  final List<PlaceEntity> places;

  NearBySearchLoaded(this.places);
}

class NearBySearchLoadedMore extends NearBySearchState {
  final List<PlaceEntity> places;

  NearBySearchLoadedMore(this.places);
}

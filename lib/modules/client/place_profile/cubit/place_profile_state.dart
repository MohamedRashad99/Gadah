part of 'place_profile_cubit.dart';

@immutable
abstract class PlaceProfileState {}

class PlaceProfileLoading extends PlaceProfileState {}

class PlaceProfileCant extends PlaceProfileState {
  final String msg;

  PlaceProfileCant(this.msg);
}

class PlaceProfileLoaded extends PlaceProfileState {
  final PlaceDetailsEntity place;

  PlaceProfileLoaded(this.place);
}

part of 'current_location_cubit.dart';

@immutable
abstract class CurrentLocationState {}

class CurrentLocationLoading extends CurrentLocationState {}

class CurrentLocationLoaded extends CurrentLocationState {
  final String location;

  CurrentLocationLoaded(this.location);
}

class CurrentLocationError extends CurrentLocationState {
  final String error;

  CurrentLocationError(this.error);
}

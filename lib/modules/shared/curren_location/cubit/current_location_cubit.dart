import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/comman/services/location_services.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  LocationData? lastLocation;
  DateTime? lastDate;

  LocationData? get currentLocation => lastLocation;
  final _locationService = LocationServices.instance;
  late Stream<LocationData> _stream;
  StreamSubscription<LocationData>? _streamSubscription;
  CurrentLocationCubit() : super(CurrentLocationLoading()) {
    _stream = _locationService.locationStream();
    _stream.listen((event) async {
      final now = DateTime.now();
      final isAfter = lastDate == null
          ? true
          : now.isAfter(lastDate!.add(const Duration(minutes: 5)));
      if (isAfter) {
        lastLocation = event;
        lastDate = now;
        final locationname =
            await _locationService.decodeCurrentLocation(event);

        emit(CurrentLocationLoaded(locationname));
        if (AuthService.isLoggedIn) {
          await AuthService().updateUser(
            lat: event.latitude,
            lang: event.longitude,
          );
        }
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

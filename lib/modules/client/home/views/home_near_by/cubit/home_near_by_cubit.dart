import 'package:bloc/bloc.dart';

import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/comman/services/places_service.dart';
import 'package:meta/meta.dart';

part 'home_near_by_state.dart';

class HomeNearByCubit extends Cubit<HomeNearByState> {
  final placesService = PlacesService();
  HomeNearByCubit() : super(HomeNearByLoading()) {
    refresh();
  }
  Future<void> refresh() async {
    emit(HomeNearByLoading());
    try {
      final data = await placesService.findPlaces();
      emit(HomeNearByLoaded(data.results!));
    } catch (e) {
      emit(HomeNearByCant(e.toString()));
    }
  }
}

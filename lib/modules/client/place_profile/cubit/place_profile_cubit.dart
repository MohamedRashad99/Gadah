import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/comman/models/shared/places/palce_details.dart';
import 'package:gadha/comman/services/places_service.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'place_profile_state.dart';

class PlaceProfileCubit extends Cubit<PlaceProfileState> {
  final PlaceEntity _placeEntity;
  final _placesService = PlacesService();
  PlaceDetailsEntity? _placeDetailsEntity;
  PlaceDetailsEntity get place => _placeDetailsEntity!;

  PlaceProfileCubit(this._placeEntity) : super(PlaceProfileLoading()) {
    loadPlaceDetails();
  }

  Future<void> loadPlaceDetails() async {
    try {
      emit(PlaceProfileLoading());
      _placeDetailsEntity = (await _placesService.findPlaceDetails(
        _placeEntity.placeId!,
      ))
          .result;
      emit(PlaceProfileLoaded(_placeDetailsEntity!));
    } catch (e, st) {
      log(st.toString());
      emit(PlaceProfileCant(e.toString()));
    }
  }

  Future<void> sharePlace() async {
    if (_placeDetailsEntity != null &&
        _placeDetailsEntity!.url != null &&
        await canLaunch(_placeDetailsEntity!.url!)) {
      await launch(
        _placeDetailsEntity!.url!,
        statusBarBrightness: Brightness.light,
      );
    }
  }
}

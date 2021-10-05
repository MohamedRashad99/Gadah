import 'package:gadha/comman/config/app.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/comman/models/responses/places.dart';
import 'package:gadha/comman/models/shared/places/palce_details.dart';
import 'package:gadha/comman/services/location_services.dart';
import 'package:gadha/helpers/dio.dart';
import 'package:get/get.dart';

class PlacesService {
  Future<PlacesResponse> findPlaces({
    String? type,
    String? keyword,
    String? name,
  }) async {
    final location = await LocationServices.instance.getCurrentLocation();
    final res = await D.get(
      kSeachInNearByPlaces,
      query: {
        'key': kMapsApiKey,
        'location': '${location.latitude} , ${location.longitude}',
        'radius': AppConfig.maxStoresRadius,
        'language': Get.locale?.languageCode,
        // if (type != null) 'type': type,
        if (name != null) 'name ': name,
        if (keyword != null) 'keyword': keyword,
      },
    );
    final msg = res.data['status'] as String;
    if (msg == 'OK') {
      return PlacesResponse.fromMap(res.data as Map<String, dynamic>);
    } else {
      throw msg;
    }
  }

  Future<PlaceDetailsResponse> findPlaceDetails(String placeId) async {
    final res = await D.get(
      kPlaceDetails,
      query: {
        'key': kMapsApiKey,
        'place_id': placeId,
        'language': Get.locale?.languageCode,
      },
    );
    final msg = res.data['status'] as String;
    if (msg == 'OK') {
      return PlaceDetailsResponse.fromMap(res.data as Map<String, dynamic>);
    } else {
      throw msg;
    }
  }

  Future<String> findPlaceDetailsByLatLang(double lat, double lang) async {
    final res = await D.get(
      kPlaceDetailsByLatLang,
      query: {
        'key': kMapsApiKey,
        'latlng': '$lat , $lang ',
        'language': Get.locale?.languageCode,
      },
    );
    // .replaceAll('+', ''),
    final msg = res.data['status'] as String;
    if (msg == 'OK') {
      return res.data['results'][0]['formatted_address'] as String;
    } else {
      throw res.data['error_message'] as String;
    }
  }
}

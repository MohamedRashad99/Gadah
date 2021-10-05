import 'dart:async';

import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/comman/models/maps.decoded.resp.dart';
import 'package:gadha/helpers/dio.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationServices {
  static final location = Location.instance;

  LocationServices._();
  static final LocationServices instance = LocationServices._();

  num getDistanceBetwwen(
    double formLat,
    double formLng,
    double toLat,
    double toLng,
  ) {
    final distanceBetweenPoints = SphericalUtil.computeDistanceBetween(
      LatLng(formLat, formLng),
      LatLng(toLat, toLng),
    );
    return distanceBetweenPoints / 1000;
  }

  Future<LocationData> getCurrentUserLocation() async {
    return location.getLocation();
  }

  Future<String> decodeLocation(double? lat, double? long) async {
    if (lat == null || long == null) {
      log('lat = $lat , long = $long');
      return '';
    }
    try {
      final resp = await D.get(
        '$kLocationDecoder?latlng=$lat , $long&key=$kMapsApiKey',
      );
      if (resp.statusCode == HttpStatus.ok && resp.data['status'] == 'OK') {
        final result = (resp.data['results'] as List)
            .map((e) => PlaceDecodedResult.fromMap(e as Map<String, dynamic>))
            .toList();
        final parts = result.first.formattedAddress!.split(',');
        final city = parts[parts.length - 2]
            .replaceAll('0', '')
            .replaceAll('1', '')
            .replaceAll('2', '')
            .replaceAll('3', '')
            .replaceAll('4', '')
            .replaceAll('5', '')
            .replaceAll('6', '')
            .replaceAll('7', '')
            .replaceAll('8', '')
            .replaceAll('9', '');
        return '$city ${parts.last} ';
        // formatted_address

        //   final result = (resp.data['results'] as List).map((e) => PlaceDecodedResult.fromMap(e as Map<String, dynamic>)).toList();
        //   var country = '';
        //   var city = '';
        //   for (final item in result.reversed) {
        //     if (country.isEmpty && item.types!.contains('country')) {
        //       country = item.formatted_address!;
        //     } else if (country.isEmpty && item.types!.contains('country')) {
        //       city = item.formatted_address!;
        //     }
        //   }
        //   if (['plus_code']['compound_code'] != null) {
        //     final data = resp.data['results']['plus_code']['compound_code'] as String;
        //     return data.split(',').last;
        //   } else {
        //     return resp.data['results'][0]['formatted_address'] as String? ?? '';
        //   }
      } else {
        log(resp.data.toString());
        return resp.data['status'] ?? '';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> decodeCurrentLocation([LocationData? data]) async {
    final currentUserLocation = data ?? await getCurrentUserLocation();
    return decodeLocation(
        currentUserLocation.latitude, currentUserLocation.longitude);
  }

  Stream<LocationData> locationStream() {
    return location.onLocationChanged;
  }

  Future<void> requestLocationPermission() async {
    final isServiceEnable = await location.serviceEnabled();
    if (!isServiceEnable) throw 'must_open_location_services'.tr;
    var locationPermission = await location.hasPermission();
    if (locationPermission == PermissionStatus.denied) {
      locationPermission = await location.requestPermission();
    }
    if (locationPermission == PermissionStatus.denied) {
      throw 'location_perrmison_denied';
    }
    if (locationPermission == PermissionStatus.deniedForever) {
      throw 'must_enable_from_settings';
    }
    log(locationPermission.toString());
  }

  Future<LocationData> getCurrentLocation() async {
    await requestLocationPermission();
    final _currentLocation = await location.getLocation();
    return _currentLocation;
  }

  Future<void> launchMapDiretions({
    required String fromLat,
    required String toLat,
    required String fromLang,
    required String toLang,
  }) async {
    final _oldLocationQuery = '$fromLat,$fromLang';
    final _newLocationQuery = '$toLat,$toLang';
    const _additionalQuery = 'travelmode=driving&dir_action=navigate';

    final url =
        'https://www.google.com/maps/dir/?api=1&origin=$_oldLocationQuery&destination=$_newLocationQuery&$_additionalQuery';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // static Future<LocationFuture> getCoords() async {
  //   try {
  //     await requestLocationPermission();
  //   } catch (e) {
  //     if (Platform.isIOS) {
  //       await Geolocator.openAppSettings();
  //     } else {
  //       await Geolocator.openLocationSettings();
  //     }
  //   }
  //   final position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.bestForNavigation,
  //   );
  //   return Future.value(LocationFuture(
  //     position.latitude,
  //     position.longitude,
  //     position.accuracy,
  //     position.speed,
  //     position.heading,
  //     position.timestamp,
  //   ));
  // }
}

import 'package:flutter/cupertino.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' hide LatLng;

import '../../queen.dart';

class Pick {
  Pick._();

  static Future<File?> image(BuildContext context) async {
    final result = await AssetPicker.pickAssets(
      context,
      maxAssets: 1,
      requestType: RequestType.image,
    );
    if (result != null && result.isNotEmpty) {
      return result.first.file;
    }
  }

  static Future<List<File>?> multiImages(
    BuildContext context, {
    int maxCount = 9,
  }) async {
    final result = await AssetPicker.pickAssets(
      context,
      maxAssets: maxCount,
      requestType: RequestType.image,
    );
    if (result != null && result.isNotEmpty) {
      final _files = <File>[];
      for (final asset in result) {
        final _assetFile = await asset.file;
        if (_assetFile != null) {
          _files.add(_assetFile);
        }
      }
      return _files;
    }
  }

  static Future<LocationResult?> locationFromMap(
    BuildContext context, {
    required String key,
    LatLng initialCenter = const LatLng(45.521563, -122.677433),
  }) async {
    return showLocationPicker(
      context,
      key,
      initialCenter: initialCenter,
      automaticallyAnimateToCurrentLocation: true,
      //mapStylePath: 'assets/mapStyle.json',
      myLocationButtonEnabled: true,
      requiredGPS: true,
      layersButtonEnabled: true,
      countries: ['sa', 'NG'],
      resultCardAlignment: Alignment.bottomCenter,
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}

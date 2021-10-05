import 'package:flutter/material.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:get/get.dart';

import 'config/constants.dart';
import 'models/responses/places.dart';

bool get isArabic => Get.locale?.languageCode == 'ar';
TextDirection get currentTextDirection =>
    isArabic ? TextDirection.rtl : TextDirection.ltr;
TextDirection get directionReversed =>
    !isArabic ? TextDirection.rtl : TextDirection.ltr;
String fullImagePath(String? image) {
  // if (image == null) throw 'image cant be null';
  // return image ?? kStoreUrl;
  if (image == null) return kStoreUrl;
  if (image.startsWith('public')) {
    return kServerUrl + image;
  } else {
    return image;
  }
}

String fullPlaceImagePath(Photo photo) {
  return 'https://maps.googleapis.com/maps/api/place/photo?photoreference=${photo.photoReference}&maxheight=${photo.height}&maxwidth=${photo.width}&key=$kMapsApiKey';
}

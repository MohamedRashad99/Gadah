import 'package:flutter/material.dart';
import 'package:queen/queen.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLuncher {
  UrlLuncher._();
  static Future<void> open(String? url) async {
    if (url == null) {
      L.e('cant open url since equals null');
    } else if (await canLaunch(url)) {
      await launch(url, statusBarBrightness: Brightness.light);
    } else {
      L.e('cant open $url');
    }
  }

  static Future<void> openMap(String latitude, String longitude) async {
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

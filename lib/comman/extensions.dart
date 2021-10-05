import 'package:intl/intl.dart';
import 'package:location/location.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

extension NewFormat on DateTime {
  String get dayMonthYearNonUSFormate => DateFormat('d MMMM y').format(this);

  String get standeredForm => DateFormat('d/m/y').format(this);

  String get daySlashMonthSlashYear => DateFormat.yMd().format(this);
}

extension LocationDataExt on LocationData {
  LatLng toLatLng() {
    return LatLng(latitude!, longitude!);
  }
}

class DateTimeExtensions {
  // static String firebaseTimeNOW() {
  //   final DateTime now = DateTime.now();
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
  //   final String formatted = formatter.format(now);
  //   return formatted;
  // }
}

extension Length on num {
  // String get getDistance {
  //   const _isArabic = true;
  //   if (this < 1000) {
  //     final string = round().toString();
  //     return !_isArabic ? ('${'m'.tr} $string') : ('$string ${'m'.tr}');
  //   }
  //   final stringAsFixed = (this / 1000).toStringAsFixed(1);
  //   return !_isArabic ? ('${'km'.tr} $stringAsFixed') : ('$stringAsFixed ${'km'.tr}');
  // }

  // String get formatSeconds {
  //   int timeInSeconds = toInt();
  //   final int days = timeInSeconds ~/ 86400;
  //   timeInSeconds -= days * 86400;
  //   final int hours = timeInSeconds ~/ 3600;
  //   final int secondsLeft = timeInSeconds - hours * 3600;
  //   final int minutes = secondsLeft ~/ 60;
  //   final int seconds = secondsLeft - minutes * 60;

  //   String formattedTime = '';

  //   if (minutes < 10) formattedTime += '0';
  //   formattedTime += '$minutes:';

  //   if (seconds < 10) formattedTime += '0';
  //   return formattedTime += seconds.toString();
  // }
}

extension CapitalizeStringWords on String {
  String capitalizeWords() {
    final _string = split(' ');
    final buffer = StringBuffer();
    for (var word = 0; word < _string.length; word++) {
      final isLast = word == _string.length - 1;
      final wordS = _string[word];
      buffer.write(
          '${wordS[0].toUpperCase()}${wordS.substring(1)}${isLast ? '' : ' '}');
    }
    return buffer.toString();
  }

  String capitalizeStringLatters() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

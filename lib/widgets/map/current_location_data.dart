// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:gadha/comman/functions.dart';
// import 'package:get/get.dart';
// import 'package:gadha/comman/config/colors.dart';

// class CurrentPositionLocation extends StatefulWidget {
//   @override
//   _CurrentPositionLocationState createState() => _CurrentPositionLocationState();
// }

// class _CurrentPositionLocationState extends State<CurrentPositionLocation> {
//   bool _isLoadingLacationData = true;
//   GeocodingResponse? _geocodingResponse;

//   @override
//   void initState() {
//     _getAndDecodeUserCurrentLocation();
//     super.initState();
//   }

//   Future<void> _getAndDecodeUserCurrentLocation() async {
//     try {
//       // final _location = await LocationServices.getCoords();
//       // _geocodingResponse = await LocationServices.decodeUserLocation(_location);
//       setState(() {});
//     } catch (e) {
//       log(e.toString());
//     } finally {
//       setState(() => _isLoadingLacationData = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Text _loadingText = Text(
//       "loading".tr(),
//       style: const TextStyle(
//         color: AppColors.lightBlack,
//         fontSize: 10,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//     if (_isLoadingLacationData && _geocodingResponse == null) {
//       return _loadingText;
//     }
//     final adderssComp = _geocodingResponse?.results.first.addressComponents;
//     // final _formattedAddress = adderssComp[3].shortName + ", " + adderssComp[4].longName;
//     String? _city;
//     String? _subCity;

//     if (adderssComp == null) {
//       _city = "-";
//       _subCity = "-";
//     } else {
//       for (final adressComponent in adderssComp) {
//         if (adressComponent.types.contains("administrative_area_level_2")) {
//           _city = adressComponent.longName;
//         } else if (adressComponent.types.contains("administrative_area_level_1")) {
//           _subCity = adressComponent.longName;
//         }
//       }
//     }
//     final _advancedFormattedAddress = isArabic ? "$_subCity, $_city" : "$_city ,$_subCity";

//     return Text(
//       _advancedFormattedAddress,
//       style: const TextStyle(
//         color: AppColors.lightBlack,
//         fontSize: 8,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }

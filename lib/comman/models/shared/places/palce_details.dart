import 'package:equatable/equatable.dart';

class PlaceDetailsResponse extends Equatable {
  final PlaceDetailsEntity result;
  final String status;
  const PlaceDetailsResponse({
    required this.result,
    required this.status,
  });

  PlaceDetailsResponse copyWith({
    List<dynamic>? htmlAttributions,
    PlaceDetailsEntity? result,
    String? status,
  }) {
    return PlaceDetailsResponse(
      result: result ?? this.result,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'result': result.toMap(),
      'status': status,
    };
  }

  factory PlaceDetailsResponse.fromMap(Map<String, dynamic> map) {
    return PlaceDetailsResponse(
      result: PlaceDetailsEntity.fromMap(map['result'] as Map<String, dynamic>),
      status: map['status'] as String,
    );
  }

  @override
  List<Object> get props => [result, status];
}

class PlaceDetailsEntity extends Equatable {
  final List<AddressComponent> addressComponents;
  final String? adrAaddress;
  final String? businessStatus;
  final String? formattedAaddress;
  final String? formattedPhoneNumber;
  final Geometry? geometry;
  final String? icon;
  final String? internationalPhoneNumber;
  final String name;
  final OpeningHours? openingHours;
  final String placeId;
  // final PlusCode? plusCode;
  final num? rating;
  final String? reference;
  final List<GMapPlaceReviewEntity> reviews;
  final List<String> types;
  final String? url;
  final int? userRatingsTotal;
  final int? utcOffset;
  final String? vicinity;
  final String? website;
  const PlaceDetailsEntity({
    required this.addressComponents,
    this.adrAaddress,
    this.businessStatus,
    this.formattedAaddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.internationalPhoneNumber,
    required this.name,
    this.openingHours,
    required this.placeId,
    // this.plusCode,
    this.rating,
    this.reference,
    required this.reviews,
    required this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  PlaceDetailsEntity copyWith({
    List<AddressComponent>? addressComponents,
    String? adrAaddress,
    String? businessStatus,
    String? formattedAaddress,
    String? formattedPhoneNumber,
    Geometry? geometry,
    String? icon,
    String? internationalPhoneNumber,
    String? name,
    OpeningHours? openingHours,
    String? placeId,
    // PlusCode? plusCode,
    int? rating,
    String? reference,
    List<GMapPlaceReviewEntity>? reviews,
    List<String>? types,
    String? url,
    int? userRatingsTotal,
    int? utcOffset,
    String? vicinity,
    String? website,
  }) {
    return PlaceDetailsEntity(
      addressComponents: addressComponents ?? this.addressComponents,
      adrAaddress: adrAaddress ?? this.adrAaddress,
      businessStatus: businessStatus ?? this.businessStatus,
      formattedAaddress: formattedAaddress ?? this.formattedAaddress,
      formattedPhoneNumber: formattedPhoneNumber ?? this.formattedPhoneNumber,
      geometry: geometry ?? this.geometry,
      icon: icon ?? this.icon,
      internationalPhoneNumber:
          internationalPhoneNumber ?? this.internationalPhoneNumber,
      name: name ?? this.name,
      openingHours: openingHours ?? this.openingHours,
      placeId: placeId ?? this.placeId,
      // plusCode: plusCode ?? this.plusCode,
      rating: rating ?? this.rating,
      reference: reference ?? this.reference,
      reviews: reviews ?? this.reviews,
      types: types ?? this.types,
      url: url ?? this.url,
      userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
      utcOffset: utcOffset ?? this.utcOffset,
      vicinity: vicinity ?? this.vicinity,
      website: website ?? this.website,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address_components': addressComponents.map((x) => x.toMap()).toList(),
      'adr_address': adrAaddress,
      'business_status': businessStatus,
      'formatted_address': formattedAaddress,
      'formatted_phone_number': formattedPhoneNumber,
      'geometry': geometry?.toMap(),
      'icon': icon,
      'international_phone_number': internationalPhoneNumber,
      'name': name,
      'opening_hours': openingHours?.toMap(),
      'place_id': placeId,
      // 'plus_code': plusCode?.toMap(),
      'rating': rating,
      'reference': reference,
      'reviews': reviews.map((x) => x.toMap()).toList(),
      'types': types,
      'url': url,
      'user_ratings_total': userRatingsTotal,
      'utc_offset': utcOffset,
      'vicinity': vicinity,
      'website': website,
    };
  }

  factory PlaceDetailsEntity.fromMap(Map<String, dynamic> map) {
    return PlaceDetailsEntity(
      addressComponents: map['address_components'] == null
          ? []
          : List<AddressComponent>.from(
              (map['address_components'] as List).map(
                (x) => AddressComponent.fromMap(x as Map<String, dynamic>),
              ),
            ),
      adrAaddress: map['adr_address'] as String?,
      businessStatus: map['business_status'] as String?,
      formattedAaddress: map['formatted_address'] as String?,
      formattedPhoneNumber: map['formatted_phone_number'] as String?,
      geometry: Geometry.fromMap(map['geometry'] as Map<String, dynamic>),
      icon: map['icon'] as String?,
      internationalPhoneNumber: map['international_phone_number'] as String?,
      name: map['name'] as String,
      openingHours: map['opening_hours'] == null
          ? null
          : OpeningHours.fromMap(map['opening_hours'] as Map<String, dynamic>),
      placeId: map['place_id'] as String,
      // plusCode: PlusCode.fromMap(map['plus_code'] as Map<String, dynamic>),
      rating: map['rating'] as num?,
      reference: map['reference'] as String?,
      reviews: map['reviews'] == null
          ? []
          : List<GMapPlaceReviewEntity>.from((map['reviews'] as List).map(
              (x) => GMapPlaceReviewEntity.fromMap(x as Map<String, dynamic>))),
      types:
          map['types'] == null ? [] : List<String>.from(map['types'] as List),
      url: map['url'] as String?,
      userRatingsTotal: map['user_ratings_total'] as int?,
      utcOffset: map['utc_offset'] as int?,
      vicinity: map['vicinity'] as String?,
      website: map['website'] as String?,
    );
  }

  @override
  List<Object?> get props {
    return [
      addressComponents,
      adrAaddress,
      businessStatus,
      formattedAaddress,
      formattedPhoneNumber,
      geometry,
      icon,
      internationalPhoneNumber,
      name,
      openingHours,
      placeId,
      // plusCode,
      rating,
      reference,
      reviews,
      types,
      url,
      userRatingsTotal,
      utcOffset,
      vicinity,
      website,
    ];
  }
}

class AddressComponent extends Equatable {
  final String longName;
  final String shortName;
  final List<String> types;
  const AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  AddressComponent copyWith({
    String? longName,
    String? shortName,
    List<String>? types,
  }) {
    return AddressComponent(
      longName: longName ?? this.longName,
      shortName: shortName ?? this.shortName,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'long_name': longName,
      'short_name': shortName,
      'types': types,
    };
  }

  factory AddressComponent.fromMap(Map<String, dynamic> map) {
    return AddressComponent(
      longName: map['long_name'] as String,
      shortName: map['short_name'] as String,
      types: List<String>.from(map['types'] as List),
    );
  }

  @override
  List<Object?> get props => [
        longName,
        shortName,
        types,
      ];
}

class Geometry extends Equatable {
  final Location location;
  final Viewport viewport;
  const Geometry({
    required this.location,
    required this.viewport,
  });

  Geometry copyWith({
    Location? location,
    Viewport? viewport,
  }) {
    return Geometry(
      location: location ?? this.location,
      viewport: viewport ?? this.viewport,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location.toMap(),
      'viewport': viewport.toMap(),
    };
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      viewport: Viewport.fromMap(map['viewport'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [location, viewport];
}

class Location extends Equatable {
  final double lat;
  final double lng;
  const Location({
    required this.lat,
    required this.lng,
  });

  Location copyWith({
    double? lat,
    double? lng,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  @override
  List<Object> get props => [lat, lng];
}

class Viewport extends Equatable {
  final Northeast northeast;
  final Southwest southwest;
  const Viewport({
    required this.northeast,
    required this.southwest,
  });

  Viewport copyWith({
    Northeast? northeast,
    Southwest? southwest,
  }) {
    return Viewport(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'northeast': northeast.toMap(),
      'southwest': southwest.toMap(),
    };
  }

  factory Viewport.fromMap(Map<String, dynamic> map) {
    return Viewport(
      northeast: Northeast.fromMap(map['northeast'] as Map<String, dynamic>),
      southwest: Southwest.fromMap(map['southwest'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [northeast, southwest];
}

class Northeast extends Equatable {
  final double lat;
  final double lng;
  const Northeast({
    required this.lat,
    required this.lng,
  });

  Northeast copyWith({
    double? lat,
    double? lng,
  }) {
    return Northeast(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Northeast.fromMap(Map<String, dynamic> map) {
    return Northeast(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  @override
  List<Object> get props => [lat, lng];
}

class Southwest extends Equatable {
  final double lat;
  final double lng;
  const Southwest({
    required this.lat,
    required this.lng,
  });

  Southwest copyWith({
    double? lat,
    double? lng,
  }) {
    return Southwest(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Southwest.fromMap(Map<String, dynamic> map) {
    return Southwest(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  @override
  List<Object> get props => [lat, lng];
}

class OpeningHours extends Equatable {
  final bool openNow;
  final List<Period> periods;
  final List<String> weekdayText;
  const OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  OpeningHours copyWith({
    bool? openNow,
    List<Period>? periods,
    List<String>? weekdayText,
  }) {
    return OpeningHours(
      openNow: openNow ?? this.openNow,
      periods: periods ?? this.periods,
      weekdayText: weekdayText ?? this.weekdayText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'open_now': openNow,
      'periods': periods.map((x) => x.toMap()).toList(),
      'weekday_text': weekdayText,
    };
  }

  factory OpeningHours.fromMap(Map<String, dynamic> map) {
    return OpeningHours(
      openNow: map['open_now'] as bool,
      periods: List<Period>.from((map['periods'] as List)
          .map((x) => Period.fromMap(x as Map<String, dynamic>))),
      weekdayText: List<String>.from(map['weekday_text'] as List),
    );
  }

  @override
  List<Object> get props => [openNow, periods, weekdayText];
}

class Period extends Equatable {
  // final Close close;
  final Open open;
  const Period({
    // required this.close,
    required this.open,
  });

  Period copyWith({
    // Close? close,
    Open? open,
  }) {
    return Period(
      // close: close ?? this.close,
      open: open ?? this.open,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'close': close.toMap(),
      'open': open.toMap(),
    };
  }

  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      // close: Close.fromMap(map['close'] as Map<String, dynamic>),
      open: Open.fromMap(map['open'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [
        // close,
        open,
      ];
}

// class Close extends Equatable {
//   final int day;
//   final String time;
//   const Close({
//     required this.day,
//     required this.time,
//   });

//   Close copyWith({
//     int? day,
//     String? time,
//   }) {
//     return Close(
//       day: day ?? this.day,
//       time: time ?? this.time,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'day': day,
//       'time': time,
//     };
//   }

//   factory Close.fromMap(Map<String, dynamic> map) {
//     return Close(
//       day: map['day'] as int,
//       time: map['time'] as String,
//     );
//   }

//   @override
//   List<Object> get props => [day, time];
// }

class Open extends Equatable {
  final int day;
  final String time;
  const Open({
    required this.day,
    required this.time,
  });

  Open copyWith({
    int? day,
    String? time,
  }) {
    return Open(
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'time': time,
    };
  }

  factory Open.fromMap(Map<String, dynamic> map) {
    return Open(
      day: map['day'] as int,
      time: map['time'] as String,
    );
  }

  @override
  List<Object> get props => [day, time];
}

// class PlusCode extends Equatable {
//   final String compound_code;
//   final String global_code;
//   PlusCode({
//     required this.compound_code,
//     required this.global_code,
//   });

//   PlusCode copyWith({
//     String? compound_code,
//     String? global_code,
//   }) {
//     return PlusCode(
//       compound_code: compound_code ?? this.compound_code,
//       global_code: global_code ?? this.global_code,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'compound_code': compound_code,
//       'global_code': global_code,
//     };
//   }

//   factory PlusCode.fromMap(Map<String, dynamic> map) {
//     return PlusCode(
//       compound_code: map['compound_code'],
//       global_code: map['global_code'],
//     );
//   }

//   @override
//   List<Object> get props => [compound_code, global_code];
// }

class GMapPlaceReviewEntity extends Equatable {
  final String authorName;
  final String authorUrl;
  final String language;
  final String profilePhotoUrl;
  final int rating;
  final String relativeTimeDescription;
  final String text;
  final int time;
  const GMapPlaceReviewEntity({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
  });

  GMapPlaceReviewEntity copyWith({
    String? authorName,
    String? authorUrl,
    String? language,
    String? profilePhotoUrl,
    int? rating,
    String? relativeTimeDescription,
    String? text,
    int? time,
  }) {
    return GMapPlaceReviewEntity(
      authorName: authorName ?? this.authorName,
      authorUrl: authorUrl ?? this.authorUrl,
      language: language ?? this.language,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      rating: rating ?? this.rating,
      relativeTimeDescription:
          relativeTimeDescription ?? this.relativeTimeDescription,
      text: text ?? this.text,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author_name': authorName,
      'author_url': authorUrl,
      'language': language,
      'profile_photo_url': profilePhotoUrl,
      'rating': rating,
      'relative_time_description': relativeTimeDescription,
      'text': text,
      'time': time,
    };
  }

  factory GMapPlaceReviewEntity.fromMap(Map<String, dynamic> map) {
    return GMapPlaceReviewEntity(
      authorName: map['author_name'] as String,
      authorUrl: map['author_url'] as String,
      language: map['language'] as String,
      profilePhotoUrl: map['profile_photo_url'] as String,
      rating: map['rating'] as int,
      relativeTimeDescription: map['relative_time_description'] as String,
      text: map['text'] as String,
      time: map['time'] as int,
    );
  }

  @override
  List<Object> get props {
    return [
      authorName,
      authorUrl,
      language,
      profilePhotoUrl,
      rating,
      relativeTimeDescription,
      text,
      time,
    ];
  }
}

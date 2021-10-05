import 'package:equatable/equatable.dart';

class PlacesResponse extends Equatable {
  final List<PlaceEntity>? results;
  final String? status;
  const PlacesResponse({
    this.results,
    this.status,
  });

  PlacesResponse copyWith({
    List<dynamic>? htmlAttributions,
    List<PlaceEntity>? results,
    String? status,
  }) {
    return PlacesResponse(
      results: results ?? this.results,
      status: status ?? this.status,
    );
  }

  factory PlacesResponse.fromMap(Map<String, dynamic> map) {
    return PlacesResponse(
      // htmlAttributions: map['html_attributions'],
      results: (map['results'] as List)
          .map((x) => PlaceEntity.fromMap(x as Map<String, dynamic>))
          .toList(),
      status: map['status'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        // htmlAttributions,
        results,
        status,
      ];
}

class PlaceEntity extends Equatable {
  final String? businessStatus;
  final Geometry? geometry;
  final String? icon;
  final String name;
  // final OpeningHours? openingHours;
  final List<Photo>? photos;
  final String? placeId;
  // final PlusCode? plusCode;
  // final int? priceLevel;
  final num? rating;
  final String? reference;
  // final String? scope;
  final List? types;
  final int? userRatingsTotal;
  // final String? vicinity;
  const PlaceEntity({
    this.businessStatus,
    this.geometry,
    this.icon,
    required this.name,
    // this.openingHours,
    this.photos,
    this.placeId,
    // this.plusCode,
    // this.priceLevel,
    this.rating,
    this.reference,
    // this.scope,
    this.types,
    this.userRatingsTotal,
    // this.vicinity,
  });

  PlaceEntity copyWith({
    String? businessStatus,
    Geometry? geometry,
    String? icon,
    String? name,
    // OpeningHours? openingHours,
    List<Photo>? photos,
    String? placeId,
    // PlusCode? plusCode,
    int? priceLevel,
    double? rating,
    String? reference,
    String? scope,
    List? types,
    int? userRatingsTotal,
    String? vicinity,
  }) {
    return PlaceEntity(
      businessStatus: businessStatus ?? this.businessStatus,
      geometry: geometry ?? this.geometry,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      // openingHours: openingHours ?? this.openingHours,
      photos: photos ?? this.photos,
      placeId: placeId ?? this.placeId,
      // plusCode: plusCode ?? this.plusCode,
      // priceLevel: priceLevel ?? this.priceLevel,
      rating: rating ?? this.rating,
      reference: reference ?? this.reference,
      // scope: scope ?? this.scope,
      types: types ?? this.types,
      userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
      // vicinity: vicinity ?? this.vicinity,
    );
  }

  factory PlaceEntity.fromMap(Map<String, dynamic> map) {
    return PlaceEntity(
      businessStatus: map['business_status'] as String?,
      geometry: Geometry.fromMap(map['geometry'] as Map<String, dynamic>),
      icon: map['icon'] as String?,
      name: map['name'] as String,
      // openingHours: OpeningHours.fromMap(map['opening_hours'] as Map<String, dynamic>),
      photos: (map['photos'] as List?)
          ?.map((x) => Photo.fromMap(x as Map<String, dynamic>))
          .toList(),
      placeId: map['place_id'] as String?,
      // plusCode: PlusCode.fromMap(map['plus_code'] as Map<String, dynamic>),
      // priceLevel: map['price_level'] as int,
      rating: map['rating'] as num,
      reference: map['reference'] as String?,
      // scope: map['scope'] as String?,
      types: map['types'] as List?,
      userRatingsTotal: map['user_ratings_total'] as int,
      // vicinity: map['vicinity'] as String?,
    );
  }

  @override
  List<Object?> get props {
    return [
      businessStatus,
      geometry,
      icon,
      name,
      // openingHours,
      photos,
      placeId,
      // plusCode,
      // priceLevel,
      rating,
      reference,
      // scope,
      types,
      userRatingsTotal,
      // vicinity,
    ];
  }
}

class Geometry extends Equatable {
  final Location? location;
  // final Viewport? viewport;
  const Geometry({
    this.location,
    // this.viewport,
  });

  Geometry copyWith({
    Location? location,
    // Viewport? viewport,
  }) {
    return Geometry(
      location: location ?? this.location,
      // viewport: viewport ?? this.viewport,
    );
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      // viewport: Viewport.fromMap(map['viewport'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [
        location,
        // viewport,
      ];
}

class Location extends Equatable {
  final double? lat;
  final double? lng;
  const Location({
    this.lat,
    this.lng,
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

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}

class Photo extends Equatable {
  final int? height;
  final List? htmlAttributions;
  final String? photoReference;
  final int? width;
  const Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  Photo copyWith({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
  }) {
    return Photo(
      height: height ?? this.height,
      htmlAttributions: htmlAttributions ?? this.htmlAttributions,
      photoReference: photoReference ?? this.photoReference,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'html_attributions': htmlAttributions,
      'photo_reference': photoReference,
      'width': width,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      height: map['height'] as int,
      htmlAttributions: map['html_attributions'] as List,
      photoReference: map['photo_reference'] as String?,
      width: map['width'] as int,
    );
  }

  @override
  List<Object?> get props => [height, htmlAttributions, photoReference, width];
}

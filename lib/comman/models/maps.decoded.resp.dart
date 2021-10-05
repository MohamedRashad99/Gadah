import 'package:queen/queen.dart';

class PlaceDecodedResult extends Equatable {
  final List<AddressComponent>? addressComponents;
  final String? formattedAddress;
  final String? placeId;
  final List<String>? types;
  const PlaceDecodedResult({
    this.addressComponents,
    this.formattedAddress,
    this.placeId,
    this.types,
  });

  PlaceDecodedResult copyWith({
    List<AddressComponent>? addressComponents,
    String? formattedAddress,
    // Geometry? geometry,
    String? placeId,
    // Plus_code? plus_code,
    List<String>? types,
  }) {
    return PlaceDecodedResult(
      addressComponents: addressComponents ?? this.addressComponents,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      // geometry: geometry ?? this.geometry,
      placeId: placeId ?? this.placeId,
      // plus_code: plus_code ?? this.plus_code,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address_components': addressComponents?.map((x) => x.toMap()).toList(),
      'formatted_address': formattedAddress,
      // 'geometry': geometry?.toMap(),
      'place_id': placeId,
      // 'plus_code': plus_code?.toMap(),
      'types': types,
    };
  }

  factory PlaceDecodedResult.fromMap(Map<String, dynamic> map) {
    return PlaceDecodedResult(
      addressComponents: List<AddressComponent>.from(
          (map['address_components'] as List)
              .map((x) => AddressComponent.fromMap(x as Map<String, dynamic>))),
      formattedAddress: map['formatted_address'] as String?,
      // geometry: Geometry.fromMap(map['geometry'] as Map<String, dynamic>),
      placeId: map['place_id'] as String?,
      // plus_code: Plus_code.fromMap(map['plus_code'] as Map<String, dynamic>),
      types: List<String>.from(map['types'] as List),
    );
  }

  @override
  List<Object?> get props {
    return [
      addressComponents,
      formattedAddress,
      // geometry,
      placeId,
      // plus_code,
      types,
    ];
  }
}

class AddressComponent extends Equatable {
  final String? longName;
  final String? shortName;
  final List<String>? types;
  const AddressComponent({
    this.longName,
    this.shortName,
    this.types,
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
      longName: map['long_name'] as String?,
      shortName: map['short_name'] as String,
      types: List<String>.from(map['types'] as List? ?? []),
    );
  }

  @override
  List<Object?> get props => [longName, shortName, types];
}

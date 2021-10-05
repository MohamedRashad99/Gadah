import 'package:equatable/equatable.dart';

import 'package:gadha/comman/models/shared/user.dart';

class OfferEntity extends Equatable {
  final int id;
  final String price;
  final User driver;
  const OfferEntity({
    required this.id,
    required this.price,
    required this.driver,
  });

  OfferEntity copyWith({
    int? id,
    String? price,
    User? driver,
  }) {
    return OfferEntity(
      id: id ?? this.id,
      price: price ?? this.price,
      driver: driver ?? this.driver,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_price': price,
      'driver': driver.toJson(),
    };
  }

  factory OfferEntity.fromMap(Map<String, dynamic> map) {
    return OfferEntity(
      id: map['id'],
      price: map['price'],
      driver: User.fromJson(map['driver']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        price,
        driver,
      ];
}

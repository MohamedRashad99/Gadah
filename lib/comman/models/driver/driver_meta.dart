import 'package:equatable/equatable.dart';

class UserMetaData extends Equatable {
  final num earnings;
  final num rate;
  final num depit;
  final num ordersCount;
  final num reviewsCount;

  const UserMetaData({
    required this.earnings,
    required this.rate,
    required this.depit,
    required this.ordersCount,
    required this.reviewsCount,
  });

  UserMetaData copyWith({
    num? earnings,
    num? rate,
    num? depit,
    num? ordersCount,
    num? reviewsCount,
  }) {
    return UserMetaData(
      earnings: earnings ?? this.earnings,
      rate: rate ?? this.rate,
      depit: depit ?? this.depit,
      ordersCount: ordersCount ?? this.ordersCount,
      reviewsCount: reviewsCount ?? this.reviewsCount,
    );
  }

  factory UserMetaData.fromMap(Map<String, dynamic> map) {
    return UserMetaData(
      earnings: map['earnings'],
      rate: map['rate'],
      depit: map['driver_depit'],
      ordersCount: map['orders_count'],
      reviewsCount: map['reviews_count'],
    );
  }
  @override
  List<Object> get props {
    return [
      earnings,
      rate,
      depit,
      ordersCount,
      reviewsCount,
    ];
  }
}

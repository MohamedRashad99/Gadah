import 'package:equatable/equatable.dart';

class CouponModel extends Equatable {
  final int id;
  final String coupon;
  final int value;
  final String timeOut;
  final String createdAt;
  final String updatedAt;

  // * reutrn true if the coupon is still valid
  bool get isValid => DateTime.parse(timeOut).isAfter(DateTime.now());

  const CouponModel({
    required this.id,
    required this.coupon,
    required this.value,
    required this.timeOut,
    required this.createdAt,
    required this.updatedAt,
  });

  CouponModel copyWith({
    int? id,
    String? coupon,
    int? value,
    String? timeOut,
    String? createdAt,
    String? updatedAt,
  }) {
    return CouponModel(
      id: id ?? this.id,
      coupon: coupon ?? this.coupon,
      value: value ?? this.value,
      timeOut: timeOut ?? this.timeOut,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coupon': coupon,
      'value': value,
      'time_out': timeOut,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id']?.toInt(),
      coupon: map['coupon'],
      value: map['value']?.toInt(),
      timeOut: map['time_out'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      coupon,
      value,
      timeOut,
      createdAt,
      updatedAt,
    ];
  }
}

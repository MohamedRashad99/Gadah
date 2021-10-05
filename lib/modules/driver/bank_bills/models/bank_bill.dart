import 'package:equatable/equatable.dart';

class BankBill extends Equatable {
  final int id;
  final String image;
  final bool reviewed;
  final String createdAt;
  final String updatedAt;
  const BankBill({
    required this.id,
    required this.image,
    required this.reviewed,
    required this.createdAt,
    required this.updatedAt,
  });

  BankBill copyWith({
    int? id,
    String? image,
    bool? reviewed,
    String? createdAt,
    String? updatedAt,
  }) {
    return BankBill(
      id: id ?? this.id,
      image: image ?? this.image,
      reviewed: reviewed ?? this.reviewed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'reviewed': reviewed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory BankBill.fromMap(Map<String, dynamic> map) {
    return BankBill(
      id: map['id'],
      image: map['image'],
      reviewed: map['reviewed'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      image,
      reviewed,
      createdAt,
      updatedAt,
    ];
  }
}

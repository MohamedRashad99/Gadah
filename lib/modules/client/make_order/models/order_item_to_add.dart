import 'package:equatable/equatable.dart';
import 'package:queen/queen.dart';

class OrderItemToAdd extends Equatable {
  final String name;
  final int count;
  final File? photo;
  const OrderItemToAdd({
    required this.name,
    this.count = 1,
    this.photo,
  });

  OrderItemToAdd copyWith({
    String? name,
    int? count,
    String? note,
    File? photo,
  }) {
    return OrderItemToAdd(
      name: name ?? this.name,
      count: count ?? this.count,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'count': count,
    };
  }

  @override
  List<Object?> get props => [
        name,
        count,
        photo,
      ];
}

import 'package:queen/queen.dart';

class OrderBill extends Equatable {
  final int id;
  final int orderId;
  final String image;
  final String amount;

  const OrderBill({
    required this.id,
    required this.orderId,
    required this.image,
    required this.amount,
  });

  factory OrderBill.fromJson(dynamic json) {
    return OrderBill(
        id: json['id'],
        orderId: json['order_id'],
        image: json['image'],
        amount: json['amount']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_id": orderId,
      "image": image,
      "amount": amount,
    };
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        image,
        amount,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:gadha/comman/models/shared/user.dart';

class OrderEntity extends Equatable {
  final int id;
  final String? price;
  final String status;
  final String? note;
  final User owner;
  final User? driver;
  final String? createdAt;
  final List<Product>? products;
  final Place place;
  final Place dropPlace;
  final Coupon? coupon;
  String get convId {
    if (driver == null) {
      throw 'cant find the convId since there is no driver yey';
    }
    return '${owner.id}_${driver!.id}';
  }

  // return true if the order still awaitg offers
  bool get awaiting => status == "قيد الانتظار";

  const OrderEntity({
    required this.id,
    required this.price,
    required this.status,
    required this.note,
    required this.owner,
    required this.driver,
    required this.createdAt,
    required this.products,
    required this.place,
    required this.dropPlace,
    required this.coupon,
  });

  OrderEntity copyWith({
    int? id,
    String? price,
    String? status,
    String? note,
    User? owner,
    User? driver,
    String? createdAt,
    List<Product>? products,
    Place? place,
    Place? dropPlace,
    Coupon? coupon,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      price: price ?? this.price,
      status: status ?? this.status,
      note: note ?? this.note,
      owner: owner ?? this.owner,
      driver: driver ?? this.driver,
      createdAt: createdAt ?? this.createdAt,
      products: products ?? this.products,
      place: place ?? this.place,
      coupon: coupon ?? this.coupon,
      dropPlace: dropPlace ?? this.dropPlace,
    );
  }

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    final id = map['id'] is String ? int.parse(map['id']) : map['id'];
    return OrderEntity(
      id: id,
      price: map['price'],
      status: map['status'],
      note: map['note'],
      owner: User.fromJson(map['owner'] as Map<String, dynamic>),
      driver: map['driver'] == null ? null : User.fromJson(map['driver']),
      createdAt: map['createdAt'],
      products: map['products'].isEmpty
          ? [
              const Product(id: 1, name: 'foo', quantity: 1),
            ]
          : (map['products'] as List).map((x) => Product.fromMap(x)).toList(),
      place: Place.fromMap(map['pick_place']),
      dropPlace: Place.fromMap(map['drop_place']),
      coupon: map['coupon'] == null ? null : Coupon.fromMap(map['coupon']),
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      price,
      status,
      note,
      owner,
      driver,
      createdAt,
      products,
      place,
      coupon,
      dropPlace,
      convId,
    ];
  }
}

class Product extends Equatable {
  final int id;
  final String name;
  final int quantity;
  final String? image;
  const Product({
    required this.id,
    required this.name,
    required this.quantity,
    this.image,
  });

  Product copyWith({
    int? id,
    String? name,
    int? quantity,
    String? note,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      image: map['image'],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      quantity,
      image,
    ];
  }
}

class Place extends Equatable {
  final String name;
  final String longtude;
  final String latitude;
  final String address;
  const Place({
    required this.name,
    required this.longtude,
    required this.latitude,
    required this.address,
  });

  Place copyWith({
    String? name,
    String? longtude,
    String? latitude,
    String? address,
  }) {
    return Place(
      name: name ?? this.name,
      longtude: longtude ?? this.longtude,
      latitude: latitude ?? this.latitude,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'longtude': longtude,
      'latitude': latitude,
      'address': address,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'],
      longtude: map['longitude'].toString(),
      latitude: map['latitude'].toString(),
      address: map['address'],
    );
  }

  @override
  List<Object> get props => [name, longtude, latitude, address];
}

class Coupon extends Equatable {
  final int id;
  final int value;
  const Coupon({
    required this.id,
    required this.value,
  });

  Coupon copyWith({
    int? id,
    int? value,
  }) {
    return Coupon(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      id: map['id'],
      value: map['value'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        value,
      ];
}

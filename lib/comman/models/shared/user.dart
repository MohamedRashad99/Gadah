import 'package:equatable/equatable.dart';
import 'package:queen/queen.dart';

enum UserGender { male, female }
enum UserRole { client, driver }
enum AccountStatus {
  active,
  awaiting,
  refused,
  banned,
}

extension on AccountStatus {
  String toStr() {
    switch (this) {
      case AccountStatus.active:
        return "1";
      case AccountStatus.awaiting:
        return "2";
      case AccountStatus.refused:
        return "3";
      case AccountStatus.banned:
        return "4";
    }
  }
}

AccountStatus stringToAccountStats(String status) {
  if (status == '1') {
    return AccountStatus.active;
  } else if (status == '2') {
    return AccountStatus.awaiting;
  } else if (status == '3') {
    return AccountStatus.refused;
  } else if (status == '4') {
    return AccountStatus.banned;
  } else {
    return AccountStatus.banned;
  }
}

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.accountStatus,
    required this.role,
    required this.stars,
    this.image,
    this.phone,
    this.stcpay,
    this.statusNote,
    this.gender,
    this.langtude,
    this.lattitude,
  });

  final int id;
  final num stars;
  final String name;
  final String? email;
  final UserRole role;
  final AccountStatus accountStatus;
  final UserGender? gender;
  final String? statusNote;
  final String? image;
  final String? phone;
  final String? stcpay;
  final String? lattitude;
  final String? langtude;

  bool get isDriver => role == UserRole.driver;
  User copyWith({
    int? id,
    num? stars,
    String? name,
    String? email,
    String? image,
    String? phone,
    String? stcpay,
    AccountStatus? accountStatus,
    String? statusNote,
    UserGender? gender,
    UserRole? role,
  }) =>
      User(
        id: id ?? this.id,
        stars: stars ?? this.stars,
        name: name ?? this.name,
        email: email ?? this.email,
        image: image ?? this.image,
        phone: phone ?? this.phone,
        stcpay: stcpay ?? this.stcpay,
        accountStatus: accountStatus ?? this.accountStatus,
        statusNote: statusNote ?? this.statusNote,
        gender: gender ?? this.gender,
        role: role ?? this.role,
      );
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      stars: json['stars'] ?? 0,
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      stcpay: json['stc_pay'],
      image: json['image'],
      accountStatus: stringToAccountStats(json['account_status']),
      statusNote: json['status_note'] as String?,
      gender: json['gender'] as String == 'male'
          ? UserGender.male
          : UserGender.female,
      role: findRole(json['roles'] ?? json['role']),
      langtude: json['lng'],
      lattitude: json['lat'],
    );
  }
  static UserRole findRole(dynamic roles) {
    if (roles is Map) {
      return UserRole.client;
    }
    if (roles is int) {
      return roles == 0 ? UserRole.client : UserRole.driver;
    }
    final _roles = roles.map((e) => e['name']).toList();
    if (_roles.contains('driver')) {
      return UserRole.driver;
    } else {
      return UserRole.client;
    }
  }

  @override
  List<Object?> get props {
    return [
      statusNote,
      accountStatus,
      id,
      name,
      email,
      image,
      phone,
      stcpay,
      role,
      gender,
      stars,
    ];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'stars': stars,
        'email': email,
        'image': image,
        'phone': phone,
        'stcpay': stcpay,
        'status_note': statusNote,
        'account_status': accountStatus.toStr(),
        'role': role == UserRole.client ? 0 : 1,
        'gender': gender == UserGender.male ? 'male' : 'female',
      };
}

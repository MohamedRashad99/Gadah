import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../push_notifications.dart';
import '../shared/user.dart';

extension FileToMutliPart on File {
  Future<MultipartFile> toMultiPart() async => MultipartFile.fromBytes(
        await readAsBytes(),
        filename: path.split('/').last,
      );
}

class SignUpAsClientDto extends Equatable {
  final String email;
  final String name;
  final String phone;
  final File? image;
  final String stcpay;

  final UserGender gender;

  const SignUpAsClientDto({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.stcpay,
    required this.image,
  });

  Future<Map<String, dynamic>> toMap() async {
    return {
      'mobile_token': await PushNotificationService.instance.getToken(),
      'name': name,
      'email': email,
      'phone': phone.startsWith('966') ? phone : '966$phone',
      if (stcpay.isNotEmpty)
        'stcpay': stcpay.startsWith('966') ? stcpay : '966$stcpay',
      'gender': gender == UserGender.male ? 'male' : 'female',
      'type_role': 'client',
      if (image != null) 'image': await image!.toMultiPart(),
    };
  }

  Future<FormData> toFormData() async => FormData.fromMap(await toMap());

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        image,
        gender,
        stcpay,
      ];

  SignUpAsClientDto copyWith({
    String? email,
    String? name,
    String? phone,
    File? image,
    String? stcpay,
    UserGender? gender,
  }) {
    return SignUpAsClientDto(
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      stcpay: stcpay ?? this.stcpay,
      gender: gender ?? this.gender,
    );
  }
}

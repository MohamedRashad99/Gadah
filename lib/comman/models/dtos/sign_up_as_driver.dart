import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:gadha/comman/push_notifications.dart';
import '../shared/user.dart';
import 'sign_up_as_client.dart';

class SignUpAsDriverDto extends Equatable {
  final String email;
  final String name;
  final String phone;
  final File? image;
  final String stcpay;
  final UserGender gender;
  final String idNumber;
  final String carNumber;
  final File? idCardImage;
  final File? carFormImg;
  final File? carLicenseImg;
  final File? carFrontImg;
  final File? carBackImg;
  final File? formImage;

  const SignUpAsDriverDto({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.stcpay,
    required this.image,
    required this.carNumber,
    this.idCardImage,
    this.carFormImg,
    this.carLicenseImg,
    this.carFrontImg,
    this.carBackImg,
    required this.idNumber,
    this.formImage,
  });

  SignUpAsDriverDto copyWith({
    String? name,
    String? email,
    String? phone,
    File? image,
    UserGender? gender,
    File? idCardImage,
    File? carFormImg,
    File? carLicenseImg,
    File? carFrontImg,
    File? carBackImg,
    String? stcpay,
    String? idNumber,
    String? carNumber,
  }) =>
      SignUpAsDriverDto(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        gender: gender ?? this.gender,
        idCardImage: idCardImage ?? this.idCardImage,
        carFormImg: carFormImg ?? this.carFormImg,
        carLicenseImg: carLicenseImg ?? this.carLicenseImg,
        carFrontImg: carFrontImg ?? this.carFrontImg,
        carBackImg: carBackImg ?? this.carBackImg,
        idNumber: idNumber ?? this.idNumber,
        stcpay: stcpay ?? this.stcpay,
        carNumber: carNumber ?? this.carNumber,
      );

  Future<Map<String, dynamic>> toMap() async {
    return {
      'mobile_token': await PushNotificationService.instance.getToken(),
      'name': name,
      'phone': phone.startsWith('966') ? phone : '966$phone',
      'email': email,
      if (stcpay.isNotEmpty)
        'stcpay': stcpay.startsWith('966') ? stcpay : '966$stcpay',
      'gender': gender == UserGender.male ? 'male' : 'female',
      'type_role': 'driver',
      if (idNumber.isNotEmpty) 'id_number': idNumber,
      if (carNumber.isNotEmpty) 'car_number': carNumber,
      'id_card_image': await idCardImage?.toMultiPart(),
      'image': await image?.toMultiPart(),
      'license_img': await carLicenseImg?.toMultiPart(),
      'form_img': await carFormImg?.toMultiPart(),
      'front_img': await carFrontImg?.toMultiPart(),
      'back_img': await carBackImg?.toMultiPart(),
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
        idCardImage,
        carFormImg,
        carLicenseImg,
        carFrontImg,
        carBackImg,
        stcpay,
        idNumber,
      ];
}

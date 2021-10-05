import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/comman/models/driver/driver_meta.dart';
import 'package:gadha/comman/models/dtos/sign_up_as_client.dart';
import 'package:gadha/comman/models/dtos/sign_up_as_driver.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/comman/push_notifications.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:gadha/helpers/storage.dart';
import 'package:queen/queen.dart';

// import 'media_service.dart';

class AuthService {
  static bool get isLoggedIn => userToken.isNotEmpty;

  static User? get currentUser {
    final user = AppStorage.getString('user');
    if (user.isEmpty) return null;
    return User.fromJson(jsonDecode(user) as Map<String, dynamic>);
  }

  void logout() {
    Api.delete(kLogoutUser);
    AppStorage.setString('jwt_token', '');
  }

  Future<void> _saveCurrentUser(User user) => AppStorage.setString(
        'user',
        jsonEncode(user.toJson()),
      );

  Future<void> _saveUserToken(String token) =>
      AppStorage.setString('jwt_token', token);

  static String get userToken => AppStorage.getString('jwt_token');
  static String get userTokenWithBearer => 'Bearer $userToken';

  /// *  confirm the code
  Future<User> confirmCode(String phoneNo, String pinCode) async {
    final resp = await Api.post(
      kCheckUserOTP,
      body: {
        'phone': phoneNo.startsWith('966') ? phoneNo : '966$phoneNo',
        'code': int.parse(pinCode),
        'mobile_token': await PushNotificationService.instance.getToken(),
      },
      attachToken: false,
    );

    if (resp.statusCode != HttpStatus.ok) {
      // throw resp.data;
      throw LaravelException.parse(resp.data);
    }
    final user = User.fromJson(resp.data['user']);
    await _saveCurrentUser(user);

    await _saveUserToken(resp.data['access_token']);
    return user;
  }

  // * sign up as driver `type_role` == "driver"
  Future<String> signUpAsDriver(SignUpAsDriverDto dto) async {
    final resp = await Api.post(
      kSignUp,
      attachToken: false,
      body: await dto.toFormData(),
    );
    if (resp.statusCode != HttpStatus.created) {
      throw LaravelException.parse(resp.data);
    }
    await loginWithPhoneNo(dto.phone);
    return resp.data['message'];
  }

  // * sign up as normal user `type_role` == "client"
  Future<String> signUpAsClient(SignUpAsClientDto dto) async {
    final resp = await Api.post(
      kSignUp,
      body: await dto.toFormData(),
      attachToken: false,
    );
    if (resp.statusCode != HttpStatus.created) {
      throw LaravelException.parse(resp.data);
    }
    await loginWithPhoneNo(dto.phone);

    return resp.data['message'];
  }

  // * send sms code throw the api
  Future<String> loginWithPhoneNo(String phoneNo) async {
    final resp = await Api.post(
      kLogin,
      body: {'phone': phoneNo.startsWith('966') ? phoneNo : '966$phoneNo'},
      attachToken: false,
    );
    if (resp.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(resp.data);
    }
    return resp.data['message'];
  }

  Future<User> updateUser({
    String? name,
    String? email,
    String? phone,
    File? image,
    double? lat,
    double? lang,
  }) async {
    final user = await getCurrentUserData();

    final resp = await Api.post(
      kUpdateUser,
      body: FormData.fromMap({
        'name': name ?? user.name,
        'email': email ?? user.email,
        'lat': lat ?? user.lattitude,
        'lang': lang ?? user.langtude,
        if (image != null) 'image': await MultipartFile.fromFile(image.path),
      }),
    );
    if (resp.statusCode != HttpStatus.accepted) {
      throw LaravelException.parse(resp.data);
    }
    final data = User.fromJson(resp.data['user']);
    await _saveCurrentUser(data);
    return data;
  }

  Future<User> getCurrentUserData() async {
    if (!isLoggedIn) throw 'is not logged in why get data then ?';
    final resp = await Api.get(kUserData);
    if (resp.statusCode != HttpStatus.ok) {
      throw LaravelException.parse(resp.data);
    }
    final user = User.fromJson(resp.data);
    await _saveCurrentUser(user);
    return user;
  }

  Future<bool> postDriverbankStatmentConfirmation(File file) async {
    final _file = await MultipartFile.fromFile(file.path);

    final resp = await Api.post(
      kDriverConfirmation,
      body: FormData.fromMap({'bank_payment_image': _file}),
    );

    if (resp.statusCode != 200) {
      throw LaravelException.parse(resp.data);
    }

    return true;
  }

  Future<UserMetaData> getUserMetaData() async {
    final resp = await Api.get(
      kDriverMetadata,
    );
    if (resp.statusCode != HttpStatus.ok) {
      throw LaravelException(resp.data);
    }
    return UserMetaData.fromMap(resp.data as Map<String, dynamic>);
  }
}

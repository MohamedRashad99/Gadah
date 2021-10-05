import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:queen/queen.dart';

part 'authantication_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static AuthCubit of(BuildContext context, {bool listen = false}) =>
      BlocProvider.of<AuthCubit>(context, listen: listen);
  // * auth service
  final _authService = AuthService();

  AuthCubit() : super(const UnKnown());

  /// curent user object
  User? _user;

  User? get user => _user;

  /// * current user phoneNumber
  /// needed when signup
  String phoneNo = '';

  Future<void> logout(BuildContext context) async {
    _user = null;
    _authService.logout();
    return checkUserAuthStats();
  }

  Future<void> checkUserAuthStats() async {
    try {
      if (AuthService.isLoggedIn) {
        _user = await _authService.getCurrentUserData();
        emit(LoggedIn(_user!));
      } else {
        emit(const LoggedOut());
      }
    } catch (e, st) {
      log('[gadha][auth_cubit][bug] $e \n $st');
      emit(const LoggedOut());
    }
  }
}

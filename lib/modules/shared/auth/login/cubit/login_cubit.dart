import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';

import 'package:gadha/comman/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  static LoginCubit of(BuildContext context, {bool listen = false}) =>
      BlocProvider.of<LoginCubit>(context, listen: listen);
  final _authService = AuthService();
  final AuthCubit authCubit;
  LoginCubit(this.authCubit) : super(const LoginInitial());
  Future<void> loginWithPhoneNo(String phoneNumber) async {
    emit(const TryingToSendCode());
    try {
      final _msg = await _authService.loginWithPhoneNo(phoneNumber);
      authCubit.phoneNo = phoneNumber;
      emit(CodeSent(_msg));
    } catch (e) {
      log(e.toString());
      emit(CantSendCode(e.toString()));
    }
  }
}

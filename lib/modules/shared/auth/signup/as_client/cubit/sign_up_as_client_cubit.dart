import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';
import 'package:gadha/comman/models/dtos/sign_up_as_client.dart';
import 'package:laravel_exception/laravel_exception.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'sign_up_as_client_state.dart';

class SignUpAsClientCubit extends Cubit<SignUpAsClientState> {
  final _authRepo = AuthService();
  final AuthCubit authCubit;
  static SignUpAsClientCubit of(BuildContext context) =>
      BlocProvider.of<SignUpAsClientCubit>(
        context,
        listen: false,
      );
  SignUpAsClientCubit(this.authCubit) : super(const SignUpAsClientInitial());
  Future<void> signUpAsClient(SignUpAsClientDto dto) async {
    try {
      emit(const RegisterInProgress());
      await _authRepo.signUpAsClient(dto);
      emit(const SignUpSucessd());
      authCubit.phoneNo = dto.phone;
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      emit(UnknownError(e.toString()));
    }
  }
}

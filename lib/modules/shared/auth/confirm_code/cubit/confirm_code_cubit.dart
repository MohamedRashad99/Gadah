import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';
import 'package:gadha/comman/models/shared/user.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'confirm_code_state.dart';

class ConfirmCodeCubit extends Cubit<ConfirmCodeState> {
  static ConfirmCodeCubit of(BuildContext context, {bool listen = false}) =>
      BlocProvider.of<ConfirmCodeCubit>(context);
  final _authService = AuthService();
  final AuthCubit authCubit;

  ConfirmCodeCubit(this.authCubit) : super(const ConfirmCodeInitial());
  Future<void> checkCode(String code) async {
    emit(const TryingToConfirmCode());
    try {
      final user = await _authService.confirmCode(authCubit.phoneNo, code);
      emit(ValidAuthCode(user));
      await authCubit.checkUserAuthStats();
    } catch (e, st) {
      log(st.toString());
      emit(ConfirmCodeError(e.toString()));
    }
  }
}

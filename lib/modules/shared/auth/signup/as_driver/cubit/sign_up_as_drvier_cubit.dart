import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';
import 'package:gadha/comman/models/dtos/sign_up_as_driver.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'sign_up_as_drvier_state.dart';

class SignUpAsDrvierCubit extends Cubit<SignUpAsDrvierState> {
  static SignUpAsDrvierCubit of(BuildContext context) =>
      BlocProvider.of<SignUpAsDrvierCubit>(
        context,
        listen: false,
      );
  final _authRepo = AuthService();
  final AuthCubit authCubit;

  SignUpAsDrvierCubit(this.authCubit) : super(const SignUpAsDrvierInitial());

  Future<void> signUpAsDriver(SignUpAsDriverDto dto) async {
    try {
      emit(const RegisterInProgress());
      await _authRepo.signUpAsDriver(dto);
      emit(const SignUpSucessd());
      authCubit.phoneNo = dto.phone;
    } catch (e) {
      emit(CantSignUp(e.toString()));
    }
  }
}

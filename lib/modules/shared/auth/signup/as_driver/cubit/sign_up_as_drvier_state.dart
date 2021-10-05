part of 'sign_up_as_drvier_cubit.dart';

@immutable
abstract class SignUpAsDrvierState {
  const SignUpAsDrvierState();
}

class SignUpAsDrvierInitial extends SignUpAsDrvierState {
  const SignUpAsDrvierInitial();
}

class SignUpSucessd extends SignUpAsDrvierState {
  const SignUpSucessd();
}

class CantSignUp extends SignUpAsDrvierState {
  final String error;
  const CantSignUp(this.error);
}

class RegisterInProgress extends SignUpAsDrvierState {
  const RegisterInProgress();
}

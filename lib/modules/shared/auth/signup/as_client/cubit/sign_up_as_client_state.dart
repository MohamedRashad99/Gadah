part of 'sign_up_as_client_cubit.dart';

@immutable
abstract class SignUpAsClientState {
  const SignUpAsClientState();
}

class SignUpAsClientInitial extends SignUpAsClientState {
  const SignUpAsClientInitial();
}

class SignUpSucessd extends SignUpAsClientState {
  const SignUpSucessd();
}

class CantSignUp extends SignUpAsClientState {
  final LaravelException error;
  const CantSignUp(this.error);
}

class RegisterInProgress extends SignUpAsClientState {
  const RegisterInProgress();
}

class UnknownError extends SignUpAsClientState {
  final String msg;
  const UnknownError(this.msg);
}

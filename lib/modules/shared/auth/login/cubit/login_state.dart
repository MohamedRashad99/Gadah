part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class TryingToSendCode extends LoginState {
  const TryingToSendCode();
}

class CodeSent extends LoginState {
  final String msg;
  const CodeSent(this.msg);
}

class CantSendCode extends LoginState {
  final String msg;
  const CantSendCode(this.msg);
}

class MustSignUpFirst extends LoginState {
  const MustSignUpFirst();
}

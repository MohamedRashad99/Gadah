part of 'confirm_code_cubit.dart';

@immutable
abstract class ConfirmCodeState {
  const ConfirmCodeState();
}

class ConfirmCodeInitial extends ConfirmCodeState {
  const ConfirmCodeInitial();
}

class TryingToConfirmCode extends ConfirmCodeState {
  const TryingToConfirmCode();
}

class ValidAuthCode extends ConfirmCodeState {
  final User user;
  const ValidAuthCode(this.user);
}

class ConfirmCodeError extends ConfirmCodeState {
  final String msg;
  const ConfirmCodeError(this.msg);
}

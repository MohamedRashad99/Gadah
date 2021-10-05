part of 'authantication_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class LoggedIn extends AuthState {
  final User user;
  const LoggedIn(this.user);

  @override
  List<Object?> get props => [];
}

class LoggedOut extends AuthState {
  const LoggedOut();
  @override
  List<Object?> get props => [];
}

class UnKnown extends AuthState {
  const UnKnown();
  @override
  List<Object?> get props => [];
}

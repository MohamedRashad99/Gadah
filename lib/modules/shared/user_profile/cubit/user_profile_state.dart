part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserMetaData metaData;

  UserProfileLoaded(this.metaData);
}

class UserProfileCantLoad extends UserProfileState {
  final String msg;

  UserProfileCantLoad(this.msg);
}

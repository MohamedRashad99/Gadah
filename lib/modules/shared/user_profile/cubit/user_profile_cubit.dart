import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/models/driver/driver_meta.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:meta/meta.dart';
import 'package:queen/queen.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileLoading());

  factory UserProfileCubit.of(BuildContext context) {
    return BlocProvider.of<UserProfileCubit>(context, listen: false);
  }

  Future<void> refresh() async {
    try {
      if (state is! UserProfileLoaded) {
        emit(UserProfileLoading());
      }
      emit(UserProfileLoaded(await AuthService().getUserMetaData()));
    } catch (e) {
      emit(UserProfileCantLoad(e.toString()));
    }
  }
}

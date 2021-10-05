import 'package:flutter/material.dart';
import 'package:gadha/comman/cubits/auth_cubit/authantication_cubit.dart';
import 'package:gadha/modules/shared/auth/login/page.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';

import 'package:queen/queen.dart';

class AuthBuild extends StatelessWidget {
  final Widget child;
  const AuthBuild(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (_, state) {
        if (state is UnKnown) {
          return const CenterLoading();
        } else if (state is LoggedIn) {
          return child;
        } else {
          return EnterPhoneNoPage();
        }
      },
    );
  }
}

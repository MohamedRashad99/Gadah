part of 'package:queen/src/controller/controller.dart';

mixin QThemeUtils on _QueenControllerImp {
  set theme(ThemeData theme) {
    Q.cubit.updateTheme(theme);
  }

  set primaryColor(Color pk) => theme = Q.theme.copyWith(primaryColor: pk);
}

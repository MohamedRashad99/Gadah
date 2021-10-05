import 'dart:ui' as ui;

import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:queen/queen.dart';
import 'package:queen/src/blocs/obs.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'package:queen/src/controller/parts/ctx.dart';
part 'package:queen/src/controller/parts/navigator.dart';
part 'package:queen/src/controller/parts/theme.dart';
// part 'package:queen/src/controller/parts/translations.dart';
part 'package:queen/src/controller/parts/alerts.dart';
part 'package:queen/src/controller/parts/dialogs.dart';
part 'package:queen/src/controller/parts/utils.dart';

final Q = _QueenController();

class _QueenControllerImp {
  /// app key
  static GlobalKey _coreKey = GlobalKey();

  /// navigator key
  static final _navKey = GlobalKey<NavigatorState>();

  /// get the app key
  GlobalKey get key => _coreKey;

  /// get the navigator key
  GlobalKey<NavigatorState> get navKey => _navKey;

  BuildContext get context {
    if (navKey.currentContext != null) {
      return navKey.currentContext!;
    } else {
      throw "you can't use the context before the app comes to the screen";
    }
  }

  QCoreCubit get cubit => QCoreCubit.of(context);

  void _update() => cubit.refresh();

  /// restart the application
  void restart() {
    _coreKey = GlobalKey();
    _update();
  }
}

class _QueenController extends _QueenControllerImp
    with
        QUtils,
        QNavigator,
        QContextUtils,
//  QTranslator,
        QThemeUtils,
        QAlerts,
        QDialogs {
  _QueenController();

  Future<void> coreBoot() async {
    /// *
    WidgetsFlutterBinding.ensureInitialized();

    ///  setup `easy_localization`
    // await EasyLocalization.ensureInitialized();

    /// add bloc `observer`
    Bloc.observer = ConBlocObs();
  }
}

import 'package:flutter/material.dart';
import 'package:queen/queen.dart';

class QApp extends StatelessWidget {
  final Widget Function() builder;
  final List<Locale> supportedLocales;
  final String localizationFilesPath;
  final Locale fallBackLocale;
  final bool useOnlyLangCode;
  final ThemeData? initalTheme;

  const QApp({
    required this.builder,
    required this.supportedLocales,
    this.localizationFilesPath = 'assets/localization',
    this.initalTheme,
    this.fallBackLocale = const Locale('ar'),
    this.useOnlyLangCode = true,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: QCoreCubit(),
      child: BlocBuilder<QCoreCubit, CoreCubitState>(
        builder: (ctx, state) {
          return builder();
        },
      ),
    );
  }
}

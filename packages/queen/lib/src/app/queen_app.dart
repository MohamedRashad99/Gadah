import 'package:flutter/material.dart';
import 'package:queen/queen.dart';

class QueenApp extends StatelessWidget {
  final Widget Function() builder;
  final List<Locale> supportedLocales;
  final String localizationFilesPath;
  final Locale fallBackLocale;
  final Locale startLocale;
  final bool useOnlyLangCode;

  const QueenApp({
    required this.builder,
    this.supportedLocales = const <Locale>[
      Locale('ar'),
      Locale('en'),
    ],
    this.localizationFilesPath = 'assets/localization',
    this.fallBackLocale = const Locale('ar'),
    this.startLocale = const Locale('ar'),
    this.useOnlyLangCode = true,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: QCoreCubit(),
      child: BlocBuilder<QCoreCubit, CoreCubitState>(
        builder: (ctx, state) => builder(),
      ),
    );
  }
}

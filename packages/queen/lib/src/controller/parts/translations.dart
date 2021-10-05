// part of 'package:queen/src/controller/controller.dart';

// extension StringTranslator on String {
//   String get.tr => tr(this);
// }

// mixin QTranslator on _QueenControllerImp {
//   Future<void> setLocale(String langCode, [String? countryCode]) async {
//     await context.setLocale(Locale(langCode, countryCode));
//   }

//   Locale get locale => context.locale;

//   List<Locale> get supportedLocales => context.supportedLocales;

//   List<LocalizationsDelegate<dynamic>> get localizationDelegates => context.localizationDelegates;

//   bool get isRTL => locale.languageCode == 'ar';

//   /// *
//   bool get isLTR => !isRTL;

//   /// *
//   TextDirection get textDirection => isRTL ? TextDirection.rtl : TextDirection.ltr;
// }

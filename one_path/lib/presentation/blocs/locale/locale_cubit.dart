// // import 'dart:ui';

// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:one_path/core/services/localization_service.dart';

// // class LocaleCubit extends Cubit<Locale?> {
// //   LocaleCubit() : super(null);

// //   void setLocale(Locale? locale) {
// //     emit(locale);
// //   }

// //   Future<void> setLocaleAndSave(String languageCode) async {
// //     await LanguageStorage.saveLanguage(languageCode);
// //     emit(Locale(languageCode));
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class LocaleCubit extends Cubit<Locale> {
//   static const String _localeKey = 'selected_locale';
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   LocaleCubit() : super(const Locale('en')) {
//     _loadSavedLocale();
//   }

//   void _loadSavedLocale() async {
//     final String? savedLocale = await _secureStorage.read(key: _localeKey);
//     if (savedLocale != null) {
//       emit(Locale(savedLocale));
//     }
//   }

//   void setLocale(String languageCode) async {
//     await _secureStorage.write(key: _localeKey, value: languageCode);
//     emit(Locale(languageCode));
//   }

//   Future<bool> hasSavedLocale() async {
//     final locale = await _secureStorage.read(key: _localeKey);
//     return locale != null;
//   }
// }
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/services/localization_service.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({Locale initialLocale = const Locale('en')})
      : super(initialLocale);

  void setLocale(Locale locale) {
    LanguageStorage.saveLanguage(locale.languageCode);
    emit(locale);
  }
}

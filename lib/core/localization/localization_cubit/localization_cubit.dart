import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalla_notlop_app/core/constants/hive_boxes.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial()) {
    _loadSavedLanguage();
  }
  
  Locale locale = const Locale('ar');

  void _loadSavedLanguage() {
    final box = Hive.box(HiveBoxes.settingsBox);
    final savedLang = box.get('language');
    if (savedLang != null) {
      locale = Locale(savedLang);
    }
  }

  void changeLang() {
    if (locale == const Locale('ar')) {
      locale = const Locale('en');
    } else {
      locale = const Locale('ar');
    }
    Hive.box(HiveBoxes.settingsBox).put('language', locale.languageCode);
    emit(LocaleChanged());
  }

  bool isRtl() {
    return locale == const Locale('ar');
  }
}

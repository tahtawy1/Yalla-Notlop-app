import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());
  Locale locale = const Locale('ar');

  void changeLang() {
    if (locale == const Locale('ar')) {
      locale = const Locale('en');
    } else {
      locale = const Locale('ar');
    }
    emit(LocaleChanged());
  }
}

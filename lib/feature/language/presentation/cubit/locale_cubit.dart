import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/response_message.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../domain/use_cases/change_language_use_case.dart';
import '../../domain/use_cases/get_saved_language_use_case.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLanguageUseCase getSavedLanguageUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;

  LocaleCubit({
    required this.getSavedLanguageUseCase,
    required this.changeLanguageUseCase,
  }) : super(
    const ChangeLocaleState(
      locale: Locale(AppStrings.englishCode),
    ),
  ) {
  }

  String currentLanguageCode = AppStrings.englishCode;



  Future<void> getSavedLanguage() async {
    final response = await getSavedLanguageUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLanguageCode = value!;
      emit(ChangeLocaleState(locale: Locale(currentLanguageCode)));
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    final response = await changeLanguageUseCase.call(languageCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLanguageCode = languageCode;
      emit(ChangeLocaleState(locale: Locale(currentLanguageCode)));
    });
  }

  void toEnglish() => _changeLanguage(AppStrings.englishCode);

  void toArabic() => _changeLanguage(AppStrings.arabicCode);

}

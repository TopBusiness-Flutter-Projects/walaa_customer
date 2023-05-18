import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/use_cases/change_language_use_case.dart';
import '../../domain/use_cases/get_saved_language_use_case.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLanguageUseCase getSavedLanguageUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;

  LocaleCubit({
    // required this.logoutUseCase,
    required this.getSavedLanguageUseCase,
    required this.changeLanguageUseCase,
  }) : super(
          const ChangeLocaleState(
            locale: Locale(AppStrings.arabicCode),
          ),
        );

  String currentLanguageCode = AppStrings.arabicCode;

  Future<void> getSavedLanguage() async {
    final response = await getSavedLanguageUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      print('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
      print(value);
      print('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
      currentLanguageCode = value!;
      emit(ChangeLocaleState(locale: Locale(currentLanguageCode)));
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    print('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
    print('languageCode : $languageCode');
    print('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
    final response = await changeLanguageUseCase.call(languageCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLanguageCode = languageCode;
      emit(ChangeLocaleState(locale: Locale(currentLanguageCode)));
    });
  }

  void toEnglish() => _changeLanguage(AppStrings.englishCode);

  void toArabic() => _changeLanguage(AppStrings.arabicCode);
}

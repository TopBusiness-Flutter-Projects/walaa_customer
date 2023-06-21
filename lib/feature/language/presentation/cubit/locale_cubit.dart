import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/preferences/preferences.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/use_cases/change_language_use_case.dart';
import '../../domain/use_cases/get_saved_language_use_case.dart';
import '../../../../core/utils/restart_app_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLanguageUseCase getSavedLanguageUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;

  static String lang='ar';


  LocaleCubit({
    // required this.logoutUseCase,
    required this.getSavedLanguageUseCase,
    required this.changeLanguageUseCase,

  }) : super(

           ChangeLocaleState (
           locale:  Locale(lang)
          ),
        ){
    getsavelagugge();
  }

  String currentLanguageCode = AppStrings.arabicCode;
  getsavelagugge()   {
    print("llll");
    Preferences.instance.getSavedLang().then((value) => {
      lang =value,
    emit(ChangeLocaleState(locale: Locale(value)))

    });


  }
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

  Future<void> _changeLanguage(String languageCode,BuildContext context) async {
    print('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
    print('languageCode : $languageCode');
    print('*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
//    Preferences.instance.la
  
    final response = await changeLanguageUseCase.call(languageCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLanguageCode = languageCode;




      Future.delayed(Duration(milliseconds: 800),() async {
        //SharedPreferences preferences = await SharedPreferences.getInstance();
        Preferences.instance.savedLang(
             languageCode).then((value) {
          emit(ChangeLocaleState(locale: Locale(languageCode)));

          Future.delayed(
              Duration(milliseconds: 10), () {
            Phoenix.rebirth(context);
            // HotRestartController.performHotRestart(
            //     context);
          });
        }
        );
      });

    });
  }

  void toEnglish(BuildContext context) => _changeLanguage(AppStrings.englishCode,context);

  void toArabic(BuildContext context) => _changeLanguage(AppStrings.arabicCode,context);



}

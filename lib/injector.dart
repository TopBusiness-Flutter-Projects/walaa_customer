import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaa_customer/feature/cartPage/cubit/cart_cubit.dart';
import 'package:walaa_customer/feature/login/presentation/cubit/login_cubit.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';
import 'feature/contact us/presentation/cubit/contact_us_cubit.dart';
import 'feature/home page/cubit/home_cubit.dart';
import 'feature/language/data/data_sources/language_locale_data_source.dart';
import 'feature/language/data/repositories/language_repository.dart';
import 'feature/language/domain/repositories/base_language_repository.dart';
import 'feature/language/domain/use_cases/change_language_use_case.dart';
import 'feature/language/domain/use_cases/get_saved_language_use_case.dart';
import 'feature/language/presentation/cubit/locale_cubit.dart';
import 'feature/menu/cubit/menu_cubit.dart';
import 'feature/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import 'feature/privacy_terms/presentation/cubit/settings_cubit.dart';
import 'feature/profile/presentation/cubit/profile_cubit.dart';
import 'feature/register/cubit/register_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
    () => LocaleCubit(
      changeLanguageUseCase: serviceLocator(),
      getSavedLanguageUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ContactUsCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ProfileCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => NavigatorBottomCubit(
      // serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => HomeCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CartCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MenuCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => RegisterCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SettingsCubit(
      serviceLocator(),
    ),
  );

  ///////////////////////////////////////////////////////////////////////////////

  /////////////////////// UseCase ///////////////////////////
  serviceLocator.registerLazySingleton(
    () => GetSavedLanguageUseCase(
      languageRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ChangeLanguageUseCase(
      languageRepository: serviceLocator(),
    ),
  );
  ////////////////////////////////////////////////////////////

  /////////////////////// Repository ///////////////////////////
  serviceLocator.registerLazySingleton<BaseLanguageRepository>(
    () => LanguageRepository(
      languageLocaleDataSource: serviceLocator(),
    ),
  );
  ////////////////////////////////////////////////////////////

  //////////////////////// Data Sources ////////////////////////
  serviceLocator.registerLazySingleton<BaseLanguageLocaleDataSource>(
    () => LanguageLocaleDataSource(
      sharedPreferences: serviceLocator(),
    ),
  );
/////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
          () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());


  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}

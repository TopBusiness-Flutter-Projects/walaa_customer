
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/preferences/preferences.dart';
import 'package:walaa_customer/feature/cartPage/cubit/cart_cubit.dart';
import 'package:walaa_customer/feature/login/presentation/cubit/login_cubit.dart';

import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'package:walaa_customer/injector.dart' as injector;
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'feature/contact us/presentation/cubit/contact_us_cubit.dart';
import 'feature/home page/cubit/home_cubit.dart';
import 'feature/language/presentation/cubit/locale_cubit.dart';
import 'feature/menu/cubit/menu_cubit.dart';
import 'feature/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import 'feature/orders/cubit/order_cubit.dart';
import 'feature/privacy_terms/presentation/cubit/settings_cubit.dart';
import 'feature/profile/presentation/cubit/profile_cubit.dart';
import 'feature/register/cubit/register_cubit.dart';


class WalaaCustomer extends StatefulWidget {
  WalaaCustomer( {Key? key}) : super(key: key);

  @override
  State<WalaaCustomer> createState() => _WalaaCustomerState();
}

class _WalaaCustomerState extends State<WalaaCustomer> {
  String? lang;


  @override
  void initState() {
    super.initState();

getlang();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
getlang();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<LocaleCubit>()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<ContactUsCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<ProfileCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<RegisterCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<SettingsCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<NavigatorBottomCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<HomeCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<MenuCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<CartCubit>(),
        ),     
        BlocProvider(
          create: (_) =>
              injector.serviceLocator<OrderCubit>(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context1, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            locale: Locale(lang!),
           // theme: appTheme(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
          );
        },
      ),
    );
  }

  void getlang() {
    Preferences.instance.getSavedLang().then((value) =>{

    setState(() {
    lang=value;
    })
    });
  }
}
import 'package:flutter/material.dart';
import 'package:walaa_customer/feature/login/presentation/screens/login.dart';
import 'package:walaa_customer/feature/payment_screen/payment_page.dart';

import '../../core/utils/app_strings.dart';
import '../../feature/home page/screens/home_page.dart';
import '../../feature/login/presentation/screens/verfiication_screen.dart';
import '../../feature/register/screen/edit_profile_screen.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String verificationScreenRoute = '/verificationScreen';
  static const String homePageScreenRoute = '/homePageScreen';
  static const String paymentRoute = '/paymentRoute';
  static const String updateProfileRoute = '/updateProfile';

}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.verificationScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const VerificationScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) =>  LoginScreen(),
        );
      case Routes.homePageScreenRoute:
        return MaterialPageRoute(
          builder: (context) =>  HomePageScreen(),
        );
      case Routes.updateProfileRoute:
        return MaterialPageRoute(
          builder: (context) =>  EditProfileScreen(),
        );
      case Routes.paymentRoute:
        String url = settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) => paymetPage(url: url),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

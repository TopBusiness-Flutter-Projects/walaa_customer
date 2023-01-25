import 'package:walaa_customer/config/locale/app_localizations.dart';

class IsLanguage{
  static bool isEnLanguage(context){
    return AppLocalizations.of(context)!.isEnLocale;
  }
  static bool isArLanguage(context){
    return AppLocalizations.of(context)!.isArLocale;
  }
}
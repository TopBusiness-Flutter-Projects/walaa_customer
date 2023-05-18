import 'package:walaa_customer/config/locale/app_localizations.dart';


String translateText(String text, context) {
  return AppLocalizations.of(context)!.translate(text)!;
}

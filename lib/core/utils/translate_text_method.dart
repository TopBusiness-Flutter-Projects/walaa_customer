import 'package:walaa_customer/config/locale/app_localizations.dart';

// import 'package:flutter/material.dart';
//
// String tr(String text) {
//  final  MyTranslate myTranslate;
//  return myTranslate.translateText(text);
// }
//
// abstract class MyTranslate {
//   String translateText(String text);
// }
//
// class Translating implements MyTranslate {
//   final BuildContext context;
//
//   Translating({required this.context});
//
//   @override
//   String translateText(String text) {
//     return AppLocalizations.of(context)!.translate(text)!;
//   }
// }

String translateText(String text, context) {
  return AppLocalizations.of(context)!.translate(text)!;
}

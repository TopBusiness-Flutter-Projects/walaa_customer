import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_colors.dart';
import '../utils/convert_numbers_method.dart';
import '../utils/is_language_methods.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.image,
    required this.title,
    required this.textInputType,
    this.minLine = 1,
    this.isPassword = false,
    this.validatorMessage = '',
    this.controller,
    this.imageColor = Colors.grey, required this.backgroundColor,
  }) : super(key: key);
  final String image;
  final Color imageColor;
  final Color backgroundColor;
  final String title;
  final String validatorMessage;
  final int minLine;
  final bool isPassword;
  final TextInputType textInputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: AppColors.textBackground,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: image != 'null'
              ? Padding(
                  padding: EdgeInsets.only(
                    right: IsLanguage.isArLanguage(context) ? 0 : 12,
                    left: IsLanguage.isArLanguage(context) ? 12 : 0,
                  ),
                  child: SvgPicture.asset(
                    image,
                    color: imageColor,
                    height: 16,
                    width: 16,
                  ),
                )
              : null,
          prefixIconConstraints:
              const BoxConstraints(minHeight: 32, minWidth: 32),
          hintText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          fillColor: backgroundColor,
          filled: true,
        ),
        maxLines: isPassword ? 1 : 20,
        minLines: minLine,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          return null;
        },
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}

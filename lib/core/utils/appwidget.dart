import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';

class AppWidget{
  static createProgressDialog(BuildContext context, String msg) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  msg,
                  style: TextStyle(color: AppColors.black, fontSize: 15.0),
                )
              ],
            ),
          );
        });
  }

}
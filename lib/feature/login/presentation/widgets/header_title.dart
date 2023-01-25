import 'package:flutter/material.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';

class HeaderTitleWidget extends StatelessWidget {
  const HeaderTitleWidget({Key? key, required this.title, required this.des})
      : super(key: key);
  final String title;
  final String des;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,color: AppColors.textBackground),
            textAlign: TextAlign.center,
          ),
          Text(
            des,
            style:  TextStyle(color: AppColors.textBackground, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

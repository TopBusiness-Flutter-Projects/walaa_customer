import 'package:flutter/material.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';

class BrownLineWidget extends StatelessWidget {
  const BrownLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 2,
      color: AppColors.buttonBackground,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/widgets/custom_button.dart';

import '../../../contact us/presentation/screens/contact_us.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          text: 'Go',
          onClick: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ContactUsScreen())),
          color: AppColors.buttonBackground,
          paddingHorizontal: 120,
        ),
      ),
    );
  }
}

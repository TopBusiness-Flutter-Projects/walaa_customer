import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';
import '../utils/translate_text_method.dart';

class NoItemPage extends StatelessWidget {
  const NoItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(ImageAssets.noLogin),
            const SizedBox(height: 40),
            Text(
              "${translateText(AppStrings.noItem, context)} ....",
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

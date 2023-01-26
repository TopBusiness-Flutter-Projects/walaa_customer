import 'package:flutter/material.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/brown_line_widget.dart';
import '../../../../core/widgets/custom_textfield.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,

        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text('Contact Us',style: TextStyle(color: AppColors.textBackground,),),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
      ),
      body: Column(
        children: [
          Image.asset(
            ImageAssets.contactUsImage,
          ),
          CustomTextField(
            // controller: cubit.phoneController,
            image: 'null',
            backgroundColor: AppColors.transparent,
            imageColor: AppColors.textBackground,
            title: 'Name',
            validatorMessage: translateText(
              AppStrings.phoneValidatorMessage,
              context,
            ),
            textInputType: TextInputType.text,
          ),
          const BrownLineWidget(),
          const SizedBox(height: 12),
          CustomTextField(
            // controller: cubit.phoneController,
            image: 'null',
            imageColor: AppColors.textBackground,
            backgroundColor: AppColors.transparent,
            title: translateText(AppStrings.phoneNumberText, context),
            validatorMessage:
                translateText(AppStrings.phoneValidatorMessage, context),
            textInputType: TextInputType.phone,
          ),
          const BrownLineWidget(),
          const SizedBox(height: 12),
          CustomTextField(
            // controller: cubit.phoneController,
            backgroundColor: AppColors.white,
            image: 'null',
            imageColor: AppColors.textBackground,
            title: 'Subject',
            validatorMessage: translateText(
              AppStrings.phoneValidatorMessage,
              context,
            ),
            textInputType: TextInputType.text,
          ),
          const BrownLineWidget(),
          const SizedBox(height: 12),
          CustomTextField(
            // controller: cubit.phoneController,
            backgroundColor: AppColors.transparent,
            image: 'null',
            minLine: 5,
            imageColor: AppColors.textBackground,
            title: 'Message',
            validatorMessage: translateText(
              AppStrings.phoneValidatorMessage,
              context,
            ),
            textInputType: TextInputType.text,
          ),
          const BrownLineWidget(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/toast_message_method.dart';
import 'package:walaa_customer/core/widgets/custom_button.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';
import 'package:walaa_customer/feature/contact%20us/presentation/cubit/contact_us_cubit.dart';
import 'package:walaa_customer/feature/contact%20us/presentation/cubit/contact_us_cubit.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/brown_line_widget.dart';
import '../../../../core/widgets/custom_textfield.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.only(right: 16, left: 16),
            icon: Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.textBackground,
              size: 35,
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            translateText(AppStrings.contactUsText, context),
            style: TextStyle(
              color: AppColors.textBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<ContactUsCubit, ContactUsState>(
        builder: (context, state) {
          ContactUsCubit cubit = context.read<ContactUsCubit>();
          if (state is ContactUsLoading) {
            return ShowLoadingIndicator();
          } else if (state is ContactUsLoaded) {
            Future.delayed(
              Duration(milliseconds: 300),
              () {
                toastMessage(
                  'Success',
                  context,
                  color: AppColors.success,
                );
                Future.delayed(
                  Duration(milliseconds: 300),
                  () {
                    Navigator.pop(context);
                  },
                );
              },
            );
            return ShowLoadingIndicator();
          }
          return cubit.loginModel != null
              ? Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Image.asset(
                          ImageAssets.contactUsImage,
                          width: MediaQuery.of(context).size.width - 150,
                        ),
                        CustomTextField(
                          controller: cubit.nameController,
                          image: 'null',
                          backgroundColor: AppColors.transparent,
                          imageColor: AppColors.textBackground,
                          title: translateText(AppStrings.nameHint, context),
                          validatorMessage: translateText(
                            AppStrings.nameValidatorMessage,
                            context,
                          ),
                          textInputType: TextInputType.text,
                        ),
                        const BrownLineWidget(),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: cubit.phoneController,
                          image: 'null',
                          imageColor: AppColors.textBackground,
                          backgroundColor: AppColors.transparent,
                          title: translateText(AppStrings.phoneHint, context),
                          validatorMessage: translateText(
                              AppStrings.phoneValidatorMessage, context),
                          textInputType: TextInputType.phone,
                        ),
                        const BrownLineWidget(),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: cubit.subjectController,
                          backgroundColor: AppColors.transparent,
                          image: 'null',
                          imageColor: AppColors.textBackground,
                          title: translateText(AppStrings.subjectHint, context),
                          validatorMessage: translateText(
                            AppStrings.subjectValidatorMessage,
                            context,
                          ),
                          textInputType: TextInputType.text,
                        ),
                        const BrownLineWidget(),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: cubit.messageController,
                          backgroundColor: AppColors.transparent,
                          image: 'null',
                          minLine: 5,
                          imageColor: AppColors.textBackground,
                          title: translateText(AppStrings.messageHint, context),
                          validatorMessage: translateText(
                            AppStrings.messageValidatorMessage,
                            context,
                          ),
                          textInputType: TextInputType.text,
                        ),
                        const BrownLineWidget(),
                        const SizedBox(height: 60),
                        CustomButton(
                          text: translateText(AppStrings.sendBtn, context),
                          color: AppColors.buttonBackground,
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              cubit.contactUsApi();
                            }
                          },
                          borderRadius: 35,
                          paddingHorizontal: 60,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                )
              : ShowLoadingIndicator();
        },
      ),
    );
  }
}

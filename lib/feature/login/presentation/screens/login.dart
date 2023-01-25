import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/core/widgets/custom_button.dart';
import 'package:walaa_customer/core/widgets/custom_textfield.dart';
import 'package:walaa_customer/feature/login/presentation/cubit/login_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/brown_line_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          LoginCubit cubit = context.read<LoginCubit>();

          if (state is SendCodeLoading) {
            return ShowLoadingIndicator();
          } else if (state is OnSmsCodeSent) {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushNamed(
                context,
                Routes.verificationScreenRoute,
              );
            });
            return ShowLoadingIndicator();
          }

          return Form(
            key: formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    Image.asset(ImageAssets.loginImage),
                    const SizedBox(height: 25),
                    CustomTextField(
                      controller: cubit.phoneController,
                      image: ImageAssets.phoneIcon,
                      imageColor: AppColors.textBackground,
                      title: translateText(
                          AppStrings.phoneNumberText, context),
                      validatorMessage: translateText(
                          AppStrings.phoneValidatorMessage, context),
                      textInputType: TextInputType.phone,
                    ),
                    const BrownLineWidget(),
                    const SizedBox(height: 50),
                    CustomButton(
                      text: translateText(AppStrings.signInBtn, context),
                      color: AppColors.buttonBackground,
                      onClick: () {
                        if (formKey.currentState!.validate()) {
                          // cubit.phoneNumber=AppStrings.phoneCode;
                          cubit.sendSmsCode();
                        }
                      },
                      paddingHorizontal: 80,
                      borderRadius: 30,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

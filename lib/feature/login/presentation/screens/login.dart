import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';
import 'package:walaa_customer/core/utils/is_language_methods.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/core/widgets/custom_button.dart';
import 'package:walaa_customer/feature/login/presentation/cubit/login_cubit.dart';
import 'package:walaa_customer/feature/register/cubit/register_cubit.dart';
import 'package:walaa_customer/feature/register/screen/register.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/brown_line_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            LoginCubit cubit = context.read<LoginCubit>();

            if (state is SendCodeLoading || state is LoginLoading) {
              return ShowLoadingIndicator();
            } else if (state is OnSmsCodeSent) {
              Future.delayed(
                Duration(milliseconds: 500),
                () {
                  cubit.phoneController.clear();
                  Navigator.pushNamed(
                    context,
                    Routes.verificationScreenRoute,
                  );
                },
              );
              return ShowLoadingIndicator();
            }
            // if (state is LoginLoaded) {
            //   // context.read<RegisterCubit>().phoneController.text =
            //   //     cubit.phoneController.text;
            //   // Future.delayed(
            //   //   Duration(milliseconds: 500),
            //   //   () {
            //   //     Navigator.push(
            //   //       context,
            //   //       MaterialPageRoute(
            //   //         builder: (context) => RegisterScreen(
            //   //           isUpdate: false,
            //   //         ),
            //   //       ),
            //   //     );
            //   //   },
            //   // );
            //   // return ShowLoadingIndicator();
            // }
            return Form(
              key: formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      Image.asset(
                        ImageAssets.mainWalaaLogoImage,
                        height: 220,
                        width: MediaQuery.of(context).size.width * .80,
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.textFormFieldColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                ImageAssets.phoneIcon,
                                color: AppColors.textBackground,
                                height: 35,
                                width: 35,
                              ),
                              SizedBox(width: 0),
                              Expanded(
                                child: InternationalPhoneNumberInput(
                                  countries: ['SA', 'EG'],
                                  inputDecoration: InputDecoration(
                                    // contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 25),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: AppColors.textFormFieldColor,
                                    filled: true,
                                  ),
                                  locale: IsLanguage.isEnLanguage(context)
                                      ? 'en'
                                      : 'ar',

                                  searchBoxDecoration: InputDecoration(
                                    labelText: translateText(
                                        AppStrings.searchCountryText, context),
                                  ),
                                  errorMessage: null,
                                  isEnabled: true,
                                  onInputChanged: (PhoneNumber number) {
                                    cubit.phoneCode = number.dialCode!;
                                  },
                                  autoFocusSearch: true,
                                  initialValue: PhoneNumber(
                                    isoCode:
                                        cubit.phoneCode == '+966' ? "SA" : 'EG',
                                  ),
                                  selectorConfig: SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                    showFlags: false,
                                    setSelectorButtonAsPrefixIcon: false,
                                    useEmoji: true,
                                    trailingSpace: false,
                                    leadingPadding: 0,
                                  ),
                                  ignoreBlank: true,
                                  selectorTextStyle: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                  ),
                                  hintText: translateText(
                                      AppStrings.phoneNumberText, context),
                                  textStyle: TextStyle(
                                      color: AppColors.textBackground),
                                  textAlign: TextAlign.end,
                                  formatInput: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return translateText(
                                        AppStrings.phoneValidatorMessage,
                                        context,
                                      );
                                    }
                                    return null;
                                  },
                                  textFieldController: cubit.phoneController,
                                  // spaceBetweenSelectorAndTextField: 20,
                                  keyboardType: TextInputType.phone,
                                  keyboardAction: TextInputAction.go,
                                  inputBorder: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        text: translateText(AppStrings.signInBtn, context),
                        color: AppColors.buttonBackground,
                        onClick: () {
                          if (formKey.currentState!.validate()) {
                            // cubit.phoneNumber=AppStrings.phoneCode;
                            print(cubit.phoneCode);
                            cubit.isRegister = false;
                            cubit.loginPhone(
                                cubit.phoneController.text, context);
                          }
                        },
                        paddingHorizontal: 30,
                        borderRadius: 10,
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(
                                isUpdate: false,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          translateText(AppStrings.signUpBtn, context),
                          style: TextStyle(
                              color: AppColors.black.withOpacity(0.6),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:walaa_customer/config/routes/app_routes.dart';
import 'package:walaa_customer/core/utils/is_language_methods.dart';
import 'package:walaa_customer/core/utils/toast_message_method.dart';
import 'package:walaa_customer/feature/login/presentation/cubit/login_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../widgets/header_title.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final formKey = GlobalKey<FormState>();

  bool hasError = false;

  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";
  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    errorController = StreamController<ErrorAnimationType>();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is CheckCodeSuccessfully) {
              Future.delayed(const Duration(milliseconds: 500), () {
                toastMessage(
                  'Success',
                  context,
                  color: AppColors.success,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.homePageScreenRoute,
                  (route) => false,
                );
              });
              // return const ShowLoadingIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      HeaderTitleWidget(
                        title: translateText(
                            AppStrings.verificationTitle, context),
                        des:
                            translateText(AppStrings.verificationDesc, context),
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 30,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              backgroundColor: AppColors.white,
                              hintCharacter: '-',
                              textStyle:
                                  TextStyle(color: AppColors.textBackground),
                              hintStyle:
                                  TextStyle(color: AppColors.textBackground),
                              pastedTextStyle: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              appContext: context,
                              length: 6,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 5) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                inactiveColor: AppColors.transparent,
                                activeColor: AppColors.transparent,
                                shape: PinCodeFieldShape.box,
                                selectedColor: AppColors.transparent,
                              ),
                              cursorColor: AppColors.textBackground,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              errorAnimationController: errorController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          hasError
                              ? translateText(
                                  AppStrings.verificationValidatorMessage,
                                  context,
                                )
                              : "",
                          style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: translateText(AppStrings.doneBtn, context),
                        color: AppColors.buttonBackground,
                        paddingHorizontal: 40,
                        borderRadius: 30,
                        onClick: () {
                          formKey.currentState!.validate();
                          if (currentText.length != 6) {
                            errorController!.add(
                              ErrorAnimationType.shake,
                            ); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            setState(
                              () {
                                hasError = false;
                                context.read<LoginCubit>().verifySmsCode(currentText);
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: IsLanguage.isEnLanguage(context)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 8),
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  AppColors.textBackground, // Text Color
                            ),
                            child: Text(
                              translateText(AppStrings.backBtn, context),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 30),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      ImageAssets.verificationImage,
                      height: 180,
                      width: 210,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

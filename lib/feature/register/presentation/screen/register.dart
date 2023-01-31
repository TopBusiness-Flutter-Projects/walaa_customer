import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/models/login_model.dart';
import 'package:walaa_customer/core/utils/toast_message_method.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';
import 'package:walaa_customer/feature/login/presentation/cubit/login_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/brown_line_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key, required this.isUpdate}) : super(key: key);
  final bool isUpdate;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  LoginModel? loginModel;

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().checkPageInitial(widget.isUpdate);
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<RegisterCubit>().isCodeSend) {
      context.read<RegisterCubit>().registerUserData();
    }
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
            translateText(
                widget.isUpdate
                    ? AppStrings.editProfileText
                    : AppStrings.registerText,
                context),
            style: TextStyle(
              color: AppColors.textBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          RegisterCubit cubit = context.read<RegisterCubit>();
          if (state is RegisterUpdateLoading) {
            return ShowLoadingIndicator();
          }
          if (state is RegisterUpdateLoaded) {
            if (cubit.isCodeSend) {
              Preferences.instance.setUser(state.loginModel).whenComplete(
                    () => Future.delayed(
                      Duration(milliseconds: 300),
                      () {
                        Future.delayed(
                          Duration(milliseconds: 300),
                          () {
                            cubit.changeStateCubit();
                            Navigator.pop(context);
                          },
                        );
                        context.read<ProfileCubit>().getStoreUser();
                        toastMessage(
                          'Updated SuccessFully',
                          context,
                          color: AppColors.success,
                        );
                      },
                    ),
                  );
            } else {
              Preferences.instance.setUser(state.loginModel).whenComplete(
                    () => Future.delayed(
                      Duration(milliseconds: 300),
                      () {
                        Future.delayed(
                          Duration(milliseconds: 300),
                          () {
                            cubit.changeStateCubit();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.homePageScreenRoute,
                              (route) => false,
                            );
                          },
                        );
                        context.read<ProfileCubit>().getStoreUser();
                        toastMessage(
                          'Updated SuccessFully',
                          context,
                          color: AppColors.success,
                        );
                      },
                    ),
                  );
            }

            return ShowLoadingIndicator();
          }
          return cubit.loginModel != null || !widget.isUpdate
              ? Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: CircleAvatar(
                                backgroundColor: AppColors.white,
                                child: ClipOval(
                                  child: widget.isUpdate
                                      ? cubit.imagePath.isEmpty
                                          ? ManageNetworkImage(
                                              imageUrl: cubit.imageUrl,
                                              width: 140,
                                              height: 140,
                                              borderRadius: 140,
                                            )
                                          : Image.file(
                                              File(
                                                cubit.imagePath,
                                              ),
                                              width: 140.0,
                                              height: 140.0,
                                              fit: BoxFit.cover,
                                            )
                                      : cubit.imagePath.isEmpty
                                          ? Image.asset(ImageAssets.noUserImage)
                                          : Image.file(
                                              File(
                                                cubit.imagePath,
                                              ),
                                              width: 140.0,
                                              height: 140.0,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              right: MediaQuery.of(context).size.width / 2 - 70,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text('Choose'),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                60,
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<RegisterCubit>()
                                                    .pickImage(
                                                      type: 'camera',
                                                    );
                                                Navigator.of(context).pop();
                                              },
                                              child: SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.camera_alt,
                                                        size: 45,
                                                        color: AppColors.gray),
                                                    Text('camera')
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<RegisterCubit>()
                                                    .pickImage(
                                                      type: 'photo',
                                                    );
                                                Navigator.of(context).pop();
                                              },
                                              child: SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.photo,
                                                        size: 45,
                                                        color: AppColors.gray),
                                                    Text('Gallery')
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'))
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.containerBackgroundColor,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Icon(
                                    Icons.linked_camera_rounded,
                                    color: AppColors.textBackground,
                                    size: 25,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
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
                          isEnable: false,
                          imageColor: AppColors.textBackground,
                          backgroundColor: AppColors.transparent,
                          title: translateText(AppStrings.phoneHint, context),
                          validatorMessage: translateText(
                              AppStrings.phoneValidatorMessage, context),
                          textInputType: TextInputType.phone,
                        ),
                        const BrownLineWidget(),
                        const SizedBox(height: 12),
                        SizedBox(height: MediaQuery.of(context).size.width / 2),
                        SizedBox(height: MediaQuery.of(context).size.width / 4),
                        CustomButton(
                          text: translateText(AppStrings.confirmBtn, context),
                          color: AppColors.buttonBackground,
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              if (widget.isUpdate) {
                                cubit.updateUserData();
                              } else {
                                Future.delayed(
                                  Duration(milliseconds: 300),
                                  () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.verificationScreenRoute,
                                    );
                                  },
                                );
                                context.read<LoginCubit>().isRegister = true;
                                context.read<LoginCubit>().sendSmsCode();
                              }
                            }
                          },
                          borderRadius: 35,
                          paddingHorizontal: 60,
                        ),
                        const SizedBox(height: 50),
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

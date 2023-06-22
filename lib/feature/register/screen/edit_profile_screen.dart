import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/circle_network_image.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/register_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().getUserModel(isUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          RegisterCubit cubit = context.read<RegisterCubit>();

          if (state is RegisterUpdateLoading) {
            return ShowLoadingIndicator();
          }
          if (state is RegisterUpdateLoaded) {
            context.read<ProfileCubit>().getStoreUser();
            Future.delayed(
              Duration(milliseconds: 400),
              () {
          //      Navigator.pop(context);
              },
            );
            //return ShowLoadingIndicator();
          }

          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.37,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          width: double.infinity,
                          child: Card(
                            elevation: 8,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)),
                            ),
                            color: AppColors.textBackground,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 140,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  child: ClipOval(
                                    child: cubit.imagePath.isEmpty
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
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 100,
                                right:
                                    MediaQuery.of(context).size.width / 2 - 70,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.camera_alt,
                                                          size: 45,
                                                          color:
                                                              AppColors.gray),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.photo,
                                                          size: 45,
                                                          color:
                                                              AppColors.gray),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 40),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImageAssets.fullNameIcon,
                          color: AppColors.textBackground,
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'الاسم',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  CustomTextField(
                    controller: cubit.nameController,
                    image: 'null',
                    isBorder: true,
                    backgroundColor: AppColors.transparent,
                    imageColor: AppColors.textBackground,
                    title: translateText(AppStrings.nameHint, context),
                    validatorMessage: translateText(
                      AppStrings.nameValidatorMessage,
                      context,
                    ),
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 60),
                  CustomButton(
                    text: translateText('confirm', context),
                    color: AppColors.buttonBackground,
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        cubit.updateUserData();
                      }
                    },
                    borderRadius: 10,
                    paddingHorizontal: 30,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

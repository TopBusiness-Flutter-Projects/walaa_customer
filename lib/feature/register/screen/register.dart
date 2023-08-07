import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:walaa_customer/core/models/login_model.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';
import 'package:walaa_customer/feature/login/presentation/cubit/login_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/is_language_methods.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../navigation_bottom/screens/navigation_bottom.dart';
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
    //  context.read<RegisterCubit>().registerUserData(context);
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
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoaded) {
            if(state.loginModel.code==200){
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 1300),
                child: NavigationBottom(loginModel: state.loginModel),
              ),
              (route) => false,
            );
          }
          else{
            toastMessage(state.loginModel.message,context);
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = context.read<RegisterCubit>();
          if (state is RegisterUpdateLoading ||
              state is RegisterLoading ||
              state is RegisterTestPhoneLoading) {
            return ShowLoadingIndicator();
          }
          return cubit.loginModel != null || !widget.isUpdate
              ? Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 7,
                        ),
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
                          image: ImageAssets.fullNameIcon,
                          backgroundColor: AppColors.textFormFieldColor,
                          imageColor: AppColors.textBackground,
                          title: translateText(AppStrings.nameHint, context),
                          validatorMessage: translateText(
                            AppStrings.nameValidatorMessage,
                            context,
                          ),
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.textFormFieldColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                                      hintText: translateText(
                                          AppStrings.phoneNumberText, context),
                                      hintTextDirection: TextDirection.ltr,
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
                                          AppStrings.searchCountryText,
                                          context),
                                    ),
                                    errorMessage: null,
                                    isEnabled: true,
                                    onInputChanged: (PhoneNumber number) {
                                      cubit.phoneCode = number.dialCode!;
                                    },
                                    autoFocusSearch: true,
                                    initialValue: PhoneNumber(isoCode:  cubit.phoneCode=='+966'?"SA":"EG"),
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
                        const SizedBox(height: 12),
                        SizedBox(height: 60),
                        CustomButton(
                          text: translateText(AppStrings.registerText, context),
                          color: AppColors.buttonBackground,
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              // context.read<LoginCubit>().isRegister = true;
                              cubit.searchPhone(context);
                              // context.read<LoginCubit>().sendSmsCode();
                            }
                          },
                          borderRadius: 10,
                          paddingHorizontal: 30,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:walaa_customer/core/utils/is_language_methods.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../contact us/presentation/screens/contact_us.dart';
import '../../../language/presentation/cubit/locale_cubit.dart';
import '../../../privacy_terms/presentation/screen/privacy&terms.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_list_tail_widget.dart';
import '../widgets/profile_top_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   title: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(
      //           translateText(AppStrings.profileText, context),
      //           style: TextStyle(
      //             color: AppColors.textBackground,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             context.read<NavigatorBottomCubit>().changePage(0);
      //           },
      //           child: Container(
      //             width: 40,
      //             height: 40,
      //             decoration: BoxDecoration(
      //               color: AppColors.containerBackgroundColor,
      //               borderRadius: BorderRadius.circular(22),
      //             ),
      //             child: Icon(
      //               Icons.close,
      //               color: AppColors.textBackground,
      //               size: 25,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   elevation: 0,
      //   backgroundColor: AppColors.white,
      // ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          ProfileCubit profileCubit = context.read<ProfileCubit>();
          if (state is ProfileDeleteAccountLoading ||
              state is ProfileDeleteAccountLoaded) {
            return ShowLoadingIndicator();
          }
          return profileCubit.loginDataModel == null
              ? ShowLoadingIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileTopWidget(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 1,
                              color: AppColors.gray,
                            ),
                          ),
                          child: Column(
                            children: [
                              ProfileListTailWidget(
                                title: translateText(
                                        AppStrings.balanceText, context) +
                                    " , " +
                                    '${profileCubit.loginDataModel!.data!.user.balance ?? 0}' +
                                    ' ' +
                                    translateText(AppStrings.SARText, context),
                                image: ImageAssets.walletIcon,
                                imageColor: AppColors.black,
                                onclick: () async {
                                  _textFieldController.clear();
                                  var resultLabel =
                                      await _showTextInputDialog(context);
                                  if (resultLabel != null) {
                                    profileCubit.onRechargeWallet(
                                        double.parse(resultLabel), context);
                                  }
                                },
                                widget: InkWell(
                                  onTap: () {
                                    context
                                        .read<ProfileCubit>()
                                        .onGetProfileData();
                                  },
                                  child: Icon(
                                    Icons.refresh,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              ProfileListTailWidget(
                                title: translateText(
                                    AppStrings.contactUsText, context),
                                image: ImageAssets.contact_usIcon,
                                imageColor: AppColors.black,
                                onclick: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactUsScreen(),
                                  ),
                                ),
                              ),
                              ProfileListTailWidget(
                                title: translateText('lang', context),
                                image: ImageAssets.languageIcon,
                                imageColor: AppColors.black,
                                onclick: () {
                                  if (IsLanguage.isArLanguage(context)) {
                                    context.read<LocaleCubit>().toEnglish();
                                    // Locale('en');
                                    print('en');
                                  } else {
                                    print('ar');
                                    // Locale('en');
                                    context.read<LocaleCubit>().toArabic();
                                  }
                                },
                                widget: Text(IsLanguage.isArLanguage(context)
                                    ? 'ع'
                                    : 'En'),
                              ),
                              ProfileListTailWidget(
                                title: translateText(
                                    AppStrings.termsText, context),
                                image: ImageAssets.termsIcon,
                                imageColor: AppColors.black,
                                onclick: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PrivacyAndTermsScreen(
                                        title: AppStrings.termsText),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ProfileListTailWidget(
                        title: translateText(AppStrings.balanceText, context) +
                            " , " +
                            '${profileCubit.loginDataModel!.data!.user.balance ?? 0}' +
                            ' ' +
                            translateText(AppStrings.SARText, context),
                        image: ImageAssets.walletIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () async {
                          _textFieldController.clear();
                          var resultLabel = await _showTextInputDialog(context);
                          if (resultLabel != null) {
                            profileCubit.onRechargeWallet(
                                double.parse(resultLabel), context);
                          }
                        },
                        widget: InkWell(
                          onTap: () {
                            context.read<ProfileCubit>().onGetProfileData();
                          },
                          child: Icon(
                            Icons.refresh,
                            color: AppColors.buttonBackground,
                          ),
                        ),
                      ),
                      ProfileListTailWidget(
                        title: translateText(AppStrings.contactUsText, context),
                        image: ImageAssets.contact_usIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactUsScreen(),
                          ),
                        ),
                      ),
                      ProfileListTailWidget(
                        title: translateText(AppStrings.termsText, context),
                        image: ImageAssets.termsIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyAndTermsScreen(
                                title: AppStrings.termsText),
                          ),
                        ),
                      ),
                      ProfileListTailWidget(
                        title: translateText(AppStrings.privacyText, context),
                        image: ImageAssets.privacyIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyAndTermsScreen(
                              title: AppStrings.privacyText,
                            ),
                          ),
                        ),
                      ),
                      ProfileListTailWidget(
                        title: translateText(
                            AppStrings.deleteAccountText, context),
                        image: ImageAssets.deleteIcon,
                        imageColor: AppColors.buttonBackground,
                        onclick: () {
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title:
                                "\n${translateText(AppStrings.deleteAccountText, context)}",
                            desc:
                                "\n\n${translateText(AppStrings.waringDeleteAccountMessage, context)}\n\n",
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                color: AppColors.containerBackgroundColor,
                                child: Text(
                                  translateText(AppStrings.cancelBtn, context),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              DialogButton(
                                onPressed: () =>
                                    profileCubit.deleteAccount(context),
                                color: AppColors.error,
                                child: Text(
                                  translateText(AppStrings.confirmBtn, context),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          ).show();
                          // profileCubit.deleteAccount(context);
                        },
                      ),
                      SizedBox(height: 22),
                      Center(
                        child: PrettyQr(
                          typeNumber: 3,
                          size: 200,
                          data: profileCubit.loginDataModel!.data!.user.id
                              .toString(),
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          elementColor: AppColors.textBackground,
                          roundEdges: true,
                        ),
                      ),
                      SizedBox(height: 22),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Future<String?> _showTextInputDialog(BuildContext context1) async {
    return showDialog(
        context: context1,
        builder: (context) {
          return AlertDialog(
            title: Text(
              translateText(AppStrings.addBalanceText, context),
            ),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: translateText(AppStrings.addBalanceText, context),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(
                  translateText(AppStrings.addBalanceText, context),
                ),
                onPressed: () =>
                    Navigator.pop(context, _textFieldController.text),
              ),
            ],
          );
        });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:walaa_customer/core/utils/is_language_methods.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';
import 'package:restart_app/restart_app.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/restart_app_class.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/dash_line_widget.dart';
import '../../../contact us/presentation/screens/contact_us.dart';
import '../../../language/presentation/cubit/locale_cubit.dart';
import '../../../navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../../../privacy_terms/presentation/screen/privacy&terms.dart';
import '../../../splash/presentation/screens/splash_screen.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_list_tail_widget.dart';
import '../widgets/profile_top_widget.dart';
import '../screens/payment_screen.dart';

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
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is OnUrlPayLoaded) {
            //  state.model.token=cubit.userModel!.data.token;
            Navigator.pushNamed(context, Routes.paymentRoute,
                    arguments: state.data.data!.payment_url)
                .then((value) => {
                      _textFieldController.text = "",
                      context.read<ProfileCubit>().onGetProfileData()
                    });
          } // TODO: implement listener
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
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
                            padding: const EdgeInsets.all(4.0),
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
                                      translateText(
                                          AppStrings.PointText, context),
                                  image: ImageAssets.walletIcon,
                                  imageColor: AppColors.black,
                                  onclick: () async {
                                    context.read<ProfileCubit>().getPaymentPackages(context);

                                    // _textFieldController.clear();
                                    // var resultLabel =
                                    //     await _shoريwTextInputDialog(context);
                                    // if (resultLabel != null) {
                                    //   profileCubit.onRechargeWallet(
                                    //       double.parse(resultLabel), context);
                                    // }
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
                                MySeparator(),
                                ProfileListTailWidget(
                                  title: translateText('lang', context),
                                  image: ImageAssets.languageIcon,
                                  imageColor: AppColors.black,
                                  onclick: () async {

                                //    print(lan);
                                    profileCubit.changelanguage(context);

                                  },
                                  widget: Text(IsLanguage.isArLanguage(context)
                                      ? 'ع'
                                      : 'En'),
                                ),
                                MySeparator(),
                                ProfileListTailWidget(
                                  title: translateText('my_orders', context),
                                  image: ImageAssets.ordersIcon,
                                  imageColor: AppColors.black,
                                  onclick: () {
                                    Navigator.pushNamed(
                                        context, Routes.ordersRoute);
                                  },
                                ),
                                MySeparator(),
                                ProfileListTailWidget(
                                  title:
                                      translateText('update_profile', context),
                                  image: ImageAssets.updateProfileIcon,
                                  imageColor: AppColors.black,
                                  onclick: () => Navigator.pushNamed(
                                    context,
                                    Routes.updateProfileRoute,
                                  ),
                                ),
                                MySeparator(),
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
                                MySeparator(),
                                ProfileListTailWidget(
                                  title: translateText(
                                      AppStrings.termsText, context),
                                  image: ImageAssets.termsIcon,
                                  imageColor: AppColors.black,
                                  onclick: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PrivacyAndTermsScreen(
                                              title: AppStrings.termsText),
                                    ),
                                  ),
                                ),
                                MySeparator(),
                                ProfileListTailWidget(
                                  title: translateText(
                                      AppStrings.privacyText, context),
                                  image: ImageAssets.privacyIcon,
                                  imageColor: AppColors.black,
                                  onclick: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PrivacyAndTermsScreen(
                                        title: AppStrings.privacyText,
                                      ),
                                    ),
                                  ),
                                ),
                                MySeparator(),
                                ProfileListTailWidget(
                                  title: translateText('share_app', context),
                                  image: ImageAssets.shareAppIcon,
                                  imageColor: AppColors.black,
                                  onclick: () {
                                    shareApp();
                                  },
                                ),
                                MySeparator(),
                                ProfileListTailWidget(
                                  title: translateText(AppStrings.deleteAccountText, context),
                                  image: ImageAssets.deleteIcon,
                                  imageColor: AppColors.black,
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
                                            translateText(
                                                AppStrings.cancelBtn, context),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        DialogButton(
                                          onPressed: () =>
                                              profileCubit.deleteAccount(context),
                                          color: AppColors.error,
                                          child: Text(
                                            translateText(
                                                AppStrings.confirmBtn, context),
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ).show();
                                  },
                                ),
                                MySeparator(),
                                ProfileListTailWidget(
                                  title: translateText('logout', context),
                                  image: ImageAssets.logoutIcon,
                                  imageColor: AppColors.textBackground,
                                  onclick: () async {
                                    context.read<NavigatorBottomCubit>().page =
                                        0;
                                    bool result = await Preferences.instance
                                        .clearUserData();
                                    result
                                        ? Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                  milliseconds: 1300),
                                              child: SplashScreen(),
                                            ),
                                            ModalRoute.withName(
                                              Routes.loginRoute,
                                            ),
                                          )
                                        : null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Future<String?> _showTextInputDialog(BuildContext context1) async {
    return showDialog(
      context: context1,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: AppColors.dialogBackgroundColor,
          content: PaymentPackage(),
        );
      },
    );
  }

  void shareApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String url = '';
    String packageName = packageInfo.packageName;

    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/details?id=${packageName}";
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/us/app/${packageName}';
    }
    await FlutterShare.share(title: "walaa", linkUrl: url);
  }
}

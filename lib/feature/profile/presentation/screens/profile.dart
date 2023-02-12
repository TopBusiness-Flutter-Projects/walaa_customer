import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:walaa_customer/core/widgets/show_loading_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../contact us/presentation/screens/contact_us.dart';
import '../../../navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../../../privacy_terms/presentation/screen/privacy&terms.dart';
import '../../../register/presentation/screen/register.dart';
import '../../../splash/presentation/screens/splash_screen.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_list_tail_widget.dart';

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
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translateText(AppStrings.profileText, context),
                  style: TextStyle(
                    color: AppColors.textBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<NavigatorBottomCubit>().changePage(
                          0,
                          translateText(
                              ['home', 'profile'].elementAt(0), context),
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
                      Icons.close,
                      color: AppColors.textBackground,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.white,
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is OnUrlPayLoaded) {
              Navigator.pushNamed(
                context,
                Routes.paymentRoute,
                arguments: state.data.data!.payment_url,
              ).then(
                  (value) => {context.read<ProfileCubit>().onGetProfileData()});
            }
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
                          Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 3 - 60,
                                width: MediaQuery.of(context).size.width,
                                color: AppColors.transparent,
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 36,
                                    vertical: 25,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen(isUpdate: true),
                                          ),
                                        ),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .containerBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                          child: Icon(
                                            Icons.edit_calendar_outlined,
                                            color: AppColors.textBackground,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 10,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  width: 90,
                                  height: 120,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.white,
                                    child: ClipOval(
                                      child: ManageNetworkImage(
                                        imageUrl: profileCubit
                                            .loginDataModel!.data!.user.image!,
                                        width: 140,
                                        height: 140,
                                        borderRadius: 140,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Column(
                                  children: [
                                    Text(
                                      '${translateText(AppStrings.welcomeText, context)}, ${profileCubit.loginDataModel!.data!.user.name}',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textBackground,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    TextButton(
                                      onPressed: () async {
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
                                                    Routes.loginRoute),
                                              )
                                            : null;
                                      },
                                      child: Text(
                                        translateText(
                                            AppStrings.logoutText, context),
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ProfileListTailWidget(
                            title:
                                translateText(AppStrings.balanceText, context) +
                                    " , " +
                                    '${profileCubit.loginDataModel!.data!.user.balance??0}'
                                    +
                                    ' ' +
                                    translateText(AppStrings.SARText, context),
                            image: ImageAssets.walletIcon,
                            imageColor: AppColors.buttonBackground,
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
                                context.read<ProfileCubit>().onGetProfileData();
                              },
                              child: Icon(
                                Icons.refresh,
                                color: AppColors.buttonBackground,
                              ),
                            ),
                          ),
                          ProfileListTailWidget(
                            title: translateText(
                                AppStrings.contactUsText, context),
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
                            title:
                                translateText(AppStrings.privacyText, context),
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
        ));
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

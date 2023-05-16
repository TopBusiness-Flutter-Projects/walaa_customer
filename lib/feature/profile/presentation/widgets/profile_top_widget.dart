import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../../core/widgets/circle_network_image.dart';
import '../cubit/profile_cubit.dart';

class ProfileTopWidget extends StatelessWidget {
  const ProfileTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        ProfileCubit profileCubit = context.read<ProfileCubit>();

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.32,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
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
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.deleteIcon,
                                  color: AppColors.gray,
                                  height: 16,
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: ClipOval(
                          child: ManageNetworkImage(
                            imageUrl:
                                profileCubit.loginDataModel!.data!.user.image!,
                            width: 140,
                            height: 140,
                            borderRadius: 140,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${profileCubit.loginDataModel!.data!.user.name}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              ),
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   left: 0,
              //   child: Column(
              //     children: [
              //       ,
              //       SizedBox(height: 4),
              //       TextButton(
              //         onPressed: () async {
              //           context.read<NavigatorBottomCubit>().page =
              //           0;
              //           bool result = await Preferences.instance
              //               .clearUserData();
              //           result
              //               ? Navigator.pushAndRemoveUntil(
              //             context,
              //             PageTransition(
              //               type: PageTransitionType.fade,
              //               alignment: Alignment.center,
              //               duration: const Duration(
              //                   milliseconds: 1300),
              //               child: SplashScreen(),
              //             ),
              //             ModalRoute.withName(
              //                 Routes.loginRoute),
              //           )
              //               : null;
              //         },
              //         child: Text(
              //           translateText(
              //               AppStrings.logoutText, context),
              //           style: TextStyle(
              //             color: AppColors.black,
              //             fontSize: 18,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaa_customer/core/utils/assets_manager.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../login/presentation/screens/login.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('onBoarding', 'Done').then(
          (value) => Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 1300),
              child: LoginScreen(),
            ),
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
    controller.addListener(() {
      controller.index == 0
          ? setState(() {
              index = 0;
            })
          : setState(() {
              index = 1;
            });
    });

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
      ),
    );
  }

  late TabController controller;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            TabBarView(
              controller: controller,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      ImageAssets.boarding1Image,
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 6,
                      right: 0,
                      left: 0,
                      child: Text(
                        'Coffee so good,\nyour taste buds\nwill love it',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.white, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Image.asset(
                      ImageAssets.boarding2Image,
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height / 10,
                      right: 0,
                      left: 0,
                      child: CustomButton(
                        text: 'Get Started',
                        onClick: () =>setFirstInstall(),
                        color: AppColors.buttonBackground,
                        paddingHorizontal: 130,
                        borderRadius: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 15,
              left: 20,
              right: 20,
              child: SafeArea(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 4,
                      width: index == 0 ? 35 : 20,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? AppColors.onBoardingColor
                            : AppColors.gray,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      height: 4,
                      width: index == 1 ? 35 : 20,
                      decoration: BoxDecoration(
                        color: index == 1
                            ? AppColors.onBoardingColor
                            : AppColors.gray,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

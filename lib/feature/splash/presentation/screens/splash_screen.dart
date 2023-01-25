import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../login/presentation/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  // LoginDataModel loginDataModel = const LoginDataModel();

  _goNext() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 1300),
        child:  LoginScreen(),
      ),
    );
  }

  _startDelay() async {

    _timer = Timer(const Duration(milliseconds: 3000), () => _goNext());
  }

  // Future<void> _getStoreUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('user') != null) {
  //     Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
  //     LoginDataModel loginDataModel = LoginDataModel.fromJson(userMap);
  //     this.loginDataModel = loginDataModel;
  //   }
  // }

  @override
  void initState() {
    super.initState();
     _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ImageAssets.walaaLogoImage,
            ),
          ),
        ],
      ),
    );
  }
}

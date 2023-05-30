import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaa_customer/core/models/login_model.dart';
import 'package:walaa_customer/core/models/recharge_wallet_model.dart';
import 'package:walaa_customer/core/preferences/preferences.dart';
import 'package:walaa_customer/core/remote/service.dart';
import 'package:walaa_customer/core/utils/app_colors.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/appwidget.dart';
import 'package:walaa_customer/core/utils/dialogs.dart';
import 'package:walaa_customer/core/utils/toast_message_method.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/models/payment_package_model.dart';
import '../../../splash/presentation/screens/splash_screen.dart';
import '../screens/payment_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(ProfileInitial()) {
    getStoreUser();
  }

  final ServiceApi api;
  List<PackageModel> packages = [];

  LoginModel? loginDataModel;

  Future<void> getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginModel loginModel = LoginModel.fromJson(userMap);
      this.loginDataModel = loginModel;
      emit(ProfileGetUserModel());
    }
  }

  deleteAccount(BuildContext context) async {
    emit(ProfileDeleteAccountLoading());
    Navigator.pop(context);
    final response = await api.deleteAccount(loginDataModel!.data!.accessToken);
    response.fold(
      (l) {
        Future.delayed(Duration(milliseconds: 300), () {
          toastMessage(
            translateText(AppStrings.errorOccurredText, context),
            context,
            color: AppColors.error,
          );
        });
        emit(ProfileDeleteAccountError());
      },
      (r) {
        if (r.code == 200) {
          Preferences.instance.clearUserData();
          Future.delayed(Duration(milliseconds: 300), () {
            toastMessage(
              translateText(AppStrings.deleteSuccessFullyText, context),
              context,
              color: AppColors.success,
            );
            Future.delayed(Duration(seconds: 1), () {
              emit(ProfileInitial());
            });
          });
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 1300),
              child: SplashScreen(),
            ),
            ModalRoute.withName(
              Routes.loginRoute,
            ),
          );
          emit(ProfileDeleteAccountLoaded());
        } else {
          Future.delayed(Duration(milliseconds: 300), () {
            toastMessage(
              translateText(AppStrings.errorOccurredText, context),
              context,
              color: AppColors.error,
            );
          });
          emit(ProfileDeleteAccountError());
        }
      },
    );
  }

  onGetProfileData() async {
    final response = await api.getprofile(loginDataModel!.data!.accessToken);
    response.fold(
      (l) {},
      (r) {
        if (r.code == 200) {
          onRechargeDone(r);
        }
      },
    );
  }

  onRechargeDone(LoginModel userDataModel) async {
    userDataModel.data!.accessToken = loginDataModel!.data!.accessToken;
    await Preferences.instance.setUser(userDataModel);
    getStoreUser();
  }

  onRechargeWallet(int amount, BuildContext context) async {
    loadingDialog();
    final response =
        await api.chargeWallet(loginDataModel!.data!.accessToken, amount);
    response.fold(
      (l) {
        Navigator.pop(context);
        errorGetBar(translateText(AppStrings.errorOccurredText, context));
      },
      (r) {
        if (r.code == 200) {
          Navigator.pop(context);
          Navigator.pop(context);
          emit(OnUrlPayLoaded(r));
        } else {
          Navigator.pop(context);
          toastMessage(r.message, context);
        }
      },
    );
  }

  getPaymentPackages(context) async {
    loadingDialog();
    final response = await api.paymentPackages();
    response.fold(
      (l) {
        Navigator.pop(context);
        errorGetBar(translateText(AppStrings.errorOccurredText, context));
      },
      (r) {
        packages = r.data!.packages!;
        // Get.back;
        if (r.code == 200) {
          // Get.back;
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.packageRoute);

          // Get.dialog(
          //   AlertDialog(
          //     actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          //     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(16)),
          //     backgroundColor: AppColors.dialogBackgroundColor,
          //     content: PaymentPackage(),
          //   ),
          // );
          emit(ProfilePackageLoaded());
        } else {
          errorGetBar(r.message);
        }
      },
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';
import 'package:walaa_customer/feature/cartPage/cubit/cart_cubit.dart';
import 'package:walaa_customer/feature/register/cubit/register_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/models/login_model.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../navigation_bottom/cubit/navigator_bottom_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.serviceApi) : super(LoginInitial());
  final ServiceApi serviceApi;

  TextEditingController phoneController = TextEditingController();

  LoginModel? loginModel;

  bool isRegister = false;

  loginPhone(String phone, context) async {
    emit(LoginLoading());
    final response = await serviceApi.postLogin(phone,phoneCode);
    response.fold(
      (failure) => emit(LoginFailure()),
      (loginModel) {
        if (loginModel.code == 411||loginModel.code == 406) {
          errorGetBar(translateText(AppStrings.noEmailError, context));
          emit(LoginLoaded());
        } else if (loginModel.code == 200) {
          this.loginModel = loginModel;
          sendSmsCode();
          phoneController.clear();
          Navigator.pushNamed(
            context,
            Routes.verificationScreenRoute,
          );
        }
      },
    );
  }

  storeUser(LoginModel loginModel,BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(loginModel)).then((value) => {
      context.read<NavigatorBottomCubit>().onUserDataSuccess(),
      context.read<CartCubit>().getUserData()

    });
  }

  //////////////////send OTP///////////////////

  // String phoneNumber = '';
  String smsCode = '';
  String phoneCode = '+966';

  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verificationId;
  int? resendToken;

  sendSmsCode({String? code, String? phoneNum}) async {
    print('================================================');
    print(code);
    print(phoneNum);
    print('================================================');
    emit(SendCodeLoading());
    _mAuth.setSettings(forceRecaptchaFlow: true);
    _mAuth.verifyPhoneNumber(
      forceResendingToken: resendToken,
      phoneNumber: '${code ?? phoneCode}' + "${phoneNum ?? phoneController.text}",
      // timeout: Duration(seconds: 1),
      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = credential.smsCode!;
        verificationId = credential.verificationId;
        print("verificationId=>$verificationId");
        emit(OnSmsCodeSent(smsCode));
        // verifySmsCode(smsCode);
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(CheckCodeInvalidCode());
        print("Errrrorrrrr : ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        this.resendToken = resendToken;
        this.verificationId = verificationId;
        print("verificationId=>${verificationId}");
        emit(OnSmsCodeSent(''));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  verifySmsCode(String smsCode,BuildContext context) async {
    print(verificationId);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    await _mAuth.signInWithCredential(credential).then((value) {
      
      isRegister ? context.read<RegisterCubit>().registerUserData(context) :
      storeUser(loginModel!,context);
      emit(CheckCodeSuccessfully());
    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });
  }
}

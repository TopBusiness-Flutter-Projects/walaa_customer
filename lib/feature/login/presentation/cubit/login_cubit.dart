
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

TextEditingController phoneController = TextEditingController();

  //////////////////send OTP///////////////////

  // String phoneNumber = '';
  String smsCode = '';
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verificationId;
  int? resendToken;

  sendSmsCode() async {
    emit(SendCodeLoading());
    _mAuth.setSettings(forceRecaptchaFlow: true);
    _mAuth.verifyPhoneNumber(
      forceResendingToken: resendToken,
      phoneNumber: AppStrings.phoneCode+phoneController.text,
      // timeout: Duration(seconds: 1),
      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = credential.smsCode!;
        verificationId = credential.verificationId;
        print("verificationId=>$verificationId");
        emit(OnSmsCodeSent(smsCode));
        verifySmsCode(smsCode);
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
        print('kokokokokokok');
        this.verificationId = verificationId;
      },
    );
  }

  verifySmsCode(String smsCode) async {
    print(smsCode);
    print(verificationId);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    await _mAuth.signInWithCredential(credential).then((value) {
      print('LoginSuccess');
      emit(CheckCodeSuccessfully());
    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });
  }

}

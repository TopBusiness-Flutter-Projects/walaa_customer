import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:walaa_customer/config/routes/app_routes.dart';
import 'package:walaa_customer/core/models/login_model.dart';
import 'package:walaa_customer/core/remote/service.dart';
import 'package:walaa_customer/core/utils/dialogs.dart';
import 'package:walaa_customer/core/utils/translate_text_method.dart';

import '../../../../core/preferences/preferences.dart';
import '../../login/presentation/cubit/login_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.api) : super(RegisterInitial()) {
    getUserModel();
  }

  final ServiceApi api;

  LoginModel? loginModel;
  UserData? userData;
  bool isCodeSend = false;

  XFile? imageFile;
  String imagePath = '';
  String imageUrl = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // String phoneNumber = '';
  String smsCode = '';
  String phoneCode = '';

  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verificationId;
  int? resendToken;

  changeStateCubit() {
    Future.delayed(
      Duration(milliseconds: 300),
      () {
        emit(RegisterInitial());
      },
    );
  }

  getUserModel({bool isUpdate = false}) async {
    loginModel = await Preferences.instance.getUserModel();
    if (loginModel!.message != null) {
      userData = loginModel!.data!.user;
      if (isUpdate) {
        checkPageInitial(isUpdate);
      }
    }
  }

  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    print(imageFile!.path);

    // CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
    //   sourcePath: imageFile!.path,
    //   aspectRatioPresets: [
    //     CropAspectRatioPreset.square,
    //     CropAspectRatioPreset.original,
    //     CropAspectRatioPreset.ratio7x5,
    //     CropAspectRatioPreset.ratio16x9
    //   ],
    //   cropStyle: CropStyle.rectangle,
    //   compressFormat: ImageCompressFormat.png,
    //   compressQuality: 90,
    // );
    imagePath = imageFile!.path;
    emit(RegisterPickImageSuccess());
  }

  checkPageInitial(bool isUpdate) {
    isCodeSend = false;
    if (loginModel == null) {
      getUserModel(isUpdate: isUpdate);
    } else {
      if (isUpdate) {
        nameController.text = loginModel!.data!.user.name!;
        phoneController.text = loginModel!.data!.user.phone!;
        imageUrl = loginModel!.data!.user.image!;
        imagePath = '';
        emit(RegisterUserData());
      } else {
        nameController.clear();
        imageUrl = '';
        emit(RegisterUserData());
      }
    }
  }

  updateUserData() async {
    emit(RegisterUpdateLoading());
    final response = await api.updateProfile(
      UserData(
        name: nameController.text,
        image: imagePath.isEmpty ? null : imagePath,
        phone: userData!.phone!,
        phoneCode: userData!.phoneCode,
        token: loginModel!.data!.accessToken,
      ),
    );
    response.fold(
      (l) => emit(RegisterUpdateError()),
      (r) {
        Future.delayed(Duration(milliseconds: 700), () {
          emit(RegisterInitial());
        });
        emit(RegisterUpdateLoaded(r));
      },
    );
  }

  registerUserData() async {
    emit(RegisterLoading());
    final response = await api.registerUser(
      UserData(
        name: nameController.text,
        image: imagePath.isEmpty ? null : imagePath,
        phone: phoneController.text,
        phoneCode: phoneCode
      ),
    );
    response.fold(
      (l) => emit(RegisterError()),
      (r) {
        Preferences.instance.setUser(r);
        emit(RegisterLoaded(r));
        Future.delayed(Duration(milliseconds: 500), () {
          emit(RegisterInitial());
        });
      },
    );
  }

  loginPhone(String phone, context) async {
    emit(RegisterTestPhoneLoading());
    final response = await api.postLogin(phone,phoneCode);
    response.fold(
      (failure) => emit(RegisterTestPhoneError()),
      (loginModel) {
        if (loginModel.code == 411) {
          emit(RegisterTestPhoneLoaded());
        } else if (loginModel.code == 200) {
          emit(RegisterTestPhoneError());
          // this.loginModel = loginModel;
          // sendSmsCode();
        }
      },
    );
  }

  searchPhone(BuildContext context) async {
    emit(RegisterTestPhoneLoading());
    final response = await api.searchPhone(phoneController.text);
    response.fold(
      (failure) => emit(RegisterTestPhoneError()),
      (r) {
        if (r.code == 200) {
          if (r.data!.isNotEmpty) {
            errorGetBar(
              translateText('There_is_no_email_with_this_phone', context),
            );
            emit(RegisterTestPhoneLoaded());
          } else {
            //context.read<LoginCubit>().sendSmsCode(phoneCode,phoneController.text);
            context.read<LoginCubit>().isRegister = true;
            context
                .read<LoginCubit>()
                .sendSmsCode(code: phoneCode, phoneNum: phoneController.text);
            Future.delayed(
              Duration(milliseconds: 500),
              () {
                Navigator.pushNamed(
                  context,
                  Routes.verificationScreenRoute,
                );
              },
            );

            emit(RegisterTestPhoneLoaded());
          }
          // this.loginModel = loginModel;
          // sendSmsCode();
        }
      },
    );
  }

  //////////////////send OTP///////////////////

  sendSmsCode(context) async {
    emit(RegisterSendCodeLoading());
    _mAuth.setSettings(forceRecaptchaFlow: true);
    _mAuth.verifyPhoneNumber(
      forceResendingToken: resendToken,
      phoneNumber: phoneCode + phoneController.text,
      // timeout: Duration(seconds: 1),
      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = credential.smsCode!;
        verificationId = credential.verificationId;
        print("verificationId=>$verificationId");
        emit(RegisterSendCodeSent(smsCode));
        verifySmsCode(smsCode, context);
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(RegisterCheckCodeInvalidCode());
        print("Errrrorrrrr : ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        this.resendToken = resendToken;
        this.verificationId = verificationId;
        print("verificationId=>${verificationId}");
        emit(RegisterSendCodeSent(''));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  verifySmsCode(String smsCode, context) async {
    print(verificationId);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    await _mAuth.signInWithCredential(credential).then((value) {
      // isRegister?null: storeUser(loginModel!);
      registerUserData();
      emit(RegisterCheckCodeSuccessfully());
    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });
  }
}

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:walaa_customer/core/models/login_model.dart';
import 'package:walaa_customer/core/remote/service.dart';

import '../../../../core/preferences/preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.api) : super(RegisterInitial()) {
    getUserModel();
  }

  final ServiceApi api;

  LoginModel? loginModel;
  UserData? userData;
  bool isCodeSend = false;

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

  XFile? imageFile;
  String imagePath = '';
  String imageUrl = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 90,
    );
    imagePath = croppedFile!.path;
    emit(RegisterPickImageSuccess());
  }

  checkPageInitial(bool isUpdate) {
    if (loginModel == null) {
      getUserModel(isUpdate: isUpdate);
    } else {
      if (isUpdate) {
        nameController.text = loginModel!.data!.user.name!;
        phoneController.text = loginModel!.data!.user.phone!;
        imageUrl = loginModel!.data!.user.image!;
        print('imageUrl');
        print(imageUrl);
        emit(RegisterUserData());
      } else {
        nameController.clear();
        // phoneController.clear();
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
        phone: phoneController.text,
        token: loginModel!.data!.accessToken,
      ),
    );
    response.fold(
      (l) => emit(RegisterUpdateError()),
      (r) => emit(RegisterUpdateLoaded(r)),
    );
  }

  registerUserData() async {
    emit(RegisterLoading());
    final response = await api.registerUser(
      UserData(
        name: nameController.text,
        image: imagePath.isEmpty ? null : imagePath,
        phone: phoneController.text,
      ),
    );
    response.fold(
      (l) => emit(RegisterError()),
      (r) {
        emit(RegisterLoaded(r));
        Future.delayed(Duration(milliseconds: 500), () {
          emit(RegisterInitial());
        });
      },
    );
  }
}

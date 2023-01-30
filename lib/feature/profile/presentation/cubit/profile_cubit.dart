import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walaa_customer/core/models/login_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()){
    getStoreUser();
  }

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

}

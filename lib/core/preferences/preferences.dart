import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  Future<void> setFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('onBoarding', 'Done');
  }

  Future<String?> getFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('onBoarding');
    return jsonData;
  }

  Future<void> setUser(LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user',jsonEncode(LoginModel.fromJson(loginModel.toJson())));
    print(await getUserModel());
  }

  Future<LoginModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    LoginModel userModel;
    if (jsonData != null) {
      userModel = LoginModel.fromJson(jsonDecode(jsonData));
      userModel.data!.user.isLoggedIn = true;
    } else {
      userModel = LoginModel();
      UserData user = UserData();
      userModel.data?.user = user;
      userModel.data!.user.isLoggedIn = false;
    }
    return userModel;
  }

  clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('user');
  }
}
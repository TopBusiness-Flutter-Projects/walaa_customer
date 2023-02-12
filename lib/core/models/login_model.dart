// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:walaa_customer/core/utils/app_strings.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.data,
    this.message,
    this.code,
  });

  final Data? data;
  final String? message;
  final int? code;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class Data {
  Data({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  UserData user;
  String accessToken;
  String tokenType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: UserData.fromJson(json["user"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class UserData {
  UserData({
    this.id,
    this.name,
    this.phoneCode,
    this.phone,
    this.status,
    this.image,
    this.userType,
    this.balance,
    this.token,
  });

  final int? id;
  final String? name;
  final String? phoneCode;
  final String? phone;
  final int? status;
  final String? image;
  dynamic userType;
  final int? balance;
  late bool isLoggedIn = false;
  final String? token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
        status: json["status"],
        image: json["image"],
        userType: json["user_type"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_code": phoneCode,
        "phone": phone,
        "status": status,
        "image": image,
        "user_type": userType,
        "balance": balance,
      };

  Future<Map<String, dynamic>> updateToJson() async => {
        if (name != null) ...{
          "name": name,
        },
        "role_id": 2,
        "phone_code": AppStrings.phoneCode,
        if (phone != null) ...{
          "phone": phone,
        },
        if (image != null) ...{
          "image": await MultipartFile.fromFile(image!),
        }
      };
}

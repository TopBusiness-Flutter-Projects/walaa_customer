// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.data,
    required this.message,
    required this.code,
  });

 final Data? data;
 final String? message;
 final int? code;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data:json["data"]!=null? Data.fromJson(json["data"]):null,
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

  User user;
  String accessToken;
  String tokenType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access_token": accessToken,
    "token_type": tokenType,
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.phoneCode,
    required this.phone,
    required this.status,
    required this.image,
    required this.userType,
    required this.balance,
  });

  int id;
  String name;
  String phoneCode;
  String phone;
  int status;
  String image;
  int userType;
  int balance;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
}

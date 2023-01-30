import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  SettingModel({
    required this.data,
    required this.message,
    required this.code,
  });

  Data data;
  String message;
  int code;

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  Data({
    required this.id,
    required this.aboutAr,
    required this.aboutEn,
    required this.termsAr,
    required this.termsEn,
    required this.privacyAr,
    required this.privacyEn,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String aboutAr;
  String aboutEn;
  String termsAr;
  String termsEn;
  String privacyAr;
  String privacyEn;
  dynamic createdAt;
  dynamic updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    aboutAr: json["about_ar"],
    aboutEn: json["about_en"],
    termsAr: json["terms_ar"],
    termsEn: json["terms_en"],
    privacyAr: json["privacy_ar"],
    privacyEn: json["privacy_en"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "about_ar": aboutAr,
    "about_en": aboutEn,
    "terms_ar": termsAr,
    "terms_en": termsEn,
    "privacy_ar": privacyAr,
    "privacy_en": privacyEn,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

class SearchPhoneModel {
  final List<SearchPhoneDatum>? data;
  final String? message;
  final int? code;

  SearchPhoneModel({
    this.data,
    this.message,
    this.code,
  });

  factory SearchPhoneModel.fromRawJson(String str) => SearchPhoneModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchPhoneModel.fromJson(Map<String, dynamic> json) => SearchPhoneModel(
    data: json["data"] == null ? [] : List<SearchPhoneDatum>.from(json["data"]!.map((x) => SearchPhoneDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class SearchPhoneDatum {
  final int? id;
  final String? name;
  final String? phone;

  SearchPhoneDatum({
    this.id,
    this.name,
    this.phone,
  });

  factory SearchPhoneDatum.fromRawJson(String str) => SearchPhoneDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchPhoneDatum.fromJson(Map<String, dynamic> json) => SearchPhoneDatum(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
  };
}

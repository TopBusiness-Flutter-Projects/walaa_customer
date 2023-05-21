// To parse this JSON data, do
//
//     final paymentPackageModel = paymentPackageModelFromJson(jsonString);

import 'dart:convert';

class PaymentPackageModel {
  final PaymentPackageData? data;
  final String? message;
  final int? code;

  PaymentPackageModel({
    this.data,
    this.message,
    this.code,
  });

  PaymentPackageModel copyWith({
    PaymentPackageData? data,
    String? message,
    int? code,
  }) =>
      PaymentPackageModel(
        data: data ?? this.data,
        message: message ?? this.message,
        code: code ?? this.code,
      );

  factory PaymentPackageModel.fromRawJson(String str) => PaymentPackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentPackageModel.fromJson(Map<String, dynamic> json) => PaymentPackageModel(
    data: json["data"] == null ? null : PaymentPackageData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class PaymentPackageData {
  final List<PackageModel>? packages;

  PaymentPackageData({
    this.packages,
  });

  PaymentPackageData copyWith({
    List<PackageModel>? packages,
  }) =>
      PaymentPackageData(
        packages: packages ?? this.packages,
      );

  factory PaymentPackageData.fromRawJson(String str) => PaymentPackageData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentPackageData.fromJson(Map<String, dynamic> json) => PaymentPackageData(
    packages: json["packages"] == null ? [] : List<PackageModel>.from(json["packages"]!.map((x) => PackageModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "packages": packages == null ? [] : List<dynamic>.from(packages!.map((x) => x.toJson())),
  };
}

class PackageModel {
  final int? id;
  final int? price;
  final String? title;
  final String? description;

  PackageModel({
    this.id,
    this.price,
    this.title,
    this.description,
  });

  PackageModel copyWith({
    int? id,
    int? price,
    String? title,
    String? description,
  }) =>
      PackageModel(
        id: id ?? this.id,
        price: price ?? this.price,
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory PackageModel.fromRawJson(String str) => PackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    id: json["id"],
    price: json["price"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "title": title,
    "description": description,
  };
}

// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

import '../../feature/menu/models/product_data_model.dart';

class SearchProductModel {
  final List<ProductItemModel>? data;
  final String? message;
  final int? code;

  SearchProductModel({
    this.data,
    this.message,
    this.code,
  });

  factory SearchProductModel.fromRawJson(String str) => SearchProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchProductModel.fromJson(Map<String, dynamic> json) => SearchProductModel(
    data: json["data"] == null ? [] : List<ProductItemModel>.from(json["data"]!.map((x) => ProductItemModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}


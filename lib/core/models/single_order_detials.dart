// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:walaa_customer/core/models/login_model.dart';
import 'package:walaa_customer/feature/menu/models/product_data_model.dart';

import 'order_model.dart';


class SingleOrderDetailsModel {
  final OrderModel? data;
  final String? message;
  final int? code;

  SingleOrderDetailsModel({
    this.data,
    this.message,
    this.code,
  });

  factory SingleOrderDetailsModel.fromRawJson(String str) => SingleOrderDetailsModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory SingleOrderDetailsModel.fromJson(Map<String, dynamic> json) => SingleOrderDetailsModel(
    data: json["data"] == null ? null : OrderModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  // Map<String, dynamic> toJson() => {
  //   "data": data?.toJson(),
  //   "message": message,
  //   "code": code,
  // };
}





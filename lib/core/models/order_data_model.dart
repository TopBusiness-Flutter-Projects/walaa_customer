
import 'package:walaa_customer/core/models/status_resspons.dart';

import 'order_model.dart';

class OrderDataModel {
  final Data? data;
  final String? message;
  final int? code;

  OrderDataModel({
    this.data,
    this.message,
    this.code,
  });


  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

}

class Data {
   List<OrderModel>dataNew=[];
   List<OrderModel> accepted=[];



  Data.fromJson(Map<String, dynamic> json) {
    if (json['new'] != null) {
      dataNew = [];
      json['new'].forEach((v) {
        dataNew.add(new OrderModel.fromJson(v));
      });
    }
    if (json['accepted'] != null) {
      accepted = [];
      json['accepted'].forEach((v) {
        accepted.add(new OrderModel.fromJson(v));
      });
    }

  }
}

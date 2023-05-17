
import 'package:walaa_customer/core/models/login_model.dart';

import 'order_detials_model.dart';

class OrderModel {
  late int id;
  late dynamic totalPrice;
  late String note;
  late UserData userData;
  late UserData provider_data;
  late List<OrderDataDetailsModel> orderDetails;
  late String dataTime;

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['total_price'];
    note = json['note']??'';
    userData = UserData.fromJson(json['user_data']);
    provider_data = UserData.fromJson(json['provider_data']);
    if (json['order_details'] != null) {
      orderDetails = [];
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDataDetailsModel.fromJson(v));
      });
    }
    dataTime = json['data_time'];
  }
}

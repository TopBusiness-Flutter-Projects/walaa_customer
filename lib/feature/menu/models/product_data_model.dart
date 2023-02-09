import 'package:walaa_customer/feature/menu/models/product_model.dart';

import '../../../core/models/response_message.dart';

class ProductDataModel {
  List<ProductModel> data=[];
  late StatusResponse status;


  ProductDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new ProductModel.fromJson(v));
      });
    }
    status = StatusResponse.fromJson(json);
  }

}
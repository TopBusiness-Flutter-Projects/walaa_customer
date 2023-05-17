
import 'package:walaa_customer/feature/menu/models/product_data_model.dart';

class OrderDataDetailsModel{
 late int id;
 late int qty;
 late ProductItemModel product;


 OrderDataDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    product = ProductItemModel.fromJson(json['product']);  }

}

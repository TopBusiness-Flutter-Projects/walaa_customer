

import '../../feature/menu/models/product_data_model.dart';
import '../../feature/menu/models/product_model.dart';

class CartModel {
  String? phone = '';
  double? totalPrice = 0.0;
  String? note = '';
  List<OrderDetails>? orderDetails = [];
  List<ProductItemModel>? productModel = [];

  CartModel({
    this.phone,
    this.totalPrice,
    this.note,
    this.orderDetails,
    this.productModel,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    totalPrice = json['total_price'];
    note = json['note'];
    if (json['order_details'] != null) {
      orderDetails = [];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    if (json['product_model'] != null) {
      productModel = [];
      json['product_model'].forEach((v) {
        productModel!.add(new ProductItemModel.fromJson(v));
      });
    }
  }

static  Map<String, dynamic> toJson(CartModel cartModel) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = cartModel.phone;
    data['total_price'] = cartModel.totalPrice;
    data['note'] = cartModel.note;
    if (cartModel.orderDetails != null) {
      data['order_details'] = cartModel.orderDetails!.map((v) => v.toJson()).toList();
    }
    if (cartModel.productModel != null) {
      data['product_model'] = cartModel.productModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int productId = 0;
  int qty = 0;


  OrderDetails({required this.productId, required this.qty});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    return data;
  }
}

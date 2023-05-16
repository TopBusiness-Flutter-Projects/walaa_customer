// import 'package:walaa_customer/feature/menu/models/product_model.dart';
//
// import '../../../core/models/response_message.dart';
// import 'dart:convert';
//
// //
// // class ProductDataModel {
// //   List<ProductModel> data=[];
// //   late StatusResponse status;
// //
// //
// //   ProductDataModel.fromJson(Map<String, dynamic> json) {
// //     if (json['data'] != null) {
// //       data = [];
// //       json['data'].forEach((v) {
// //         data.add(new ProductModel.fromJson(v));
// //       });
// //     }
// //     status = StatusResponse.fromJson(json);
// //   }
// //
// // }
//
// class ProductDataModel {
//   final DataOfProductModel? data;
//   final String? message;
//   final int? code;
//
//   ProductDataModel({
//     this.data,
//     this.message,
//     this.code,
//   });
//
//   factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
//       ProductDataModel(
//         data: json["data"] == null
//             ? null
//             : DataOfProductModel.fromJson(json["data"]),
//         message: json["message"],
//         code: json["code"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//         "message": message,
//         "code": code,
//       };
// }
//
// class DataOfProductModel {
//   final List<ProductModel>? theBest;
//   final List<ProductModel>? products;
//
//   DataOfProductModel({
//     this.theBest,
//     this.products,
//   });
//
//   factory DataOfProductModel.fromJson(Map<String, dynamic> json) =>
//       DataOfProductModel(
//         theBest: json["the_best"] == null
//             ? []
//             : List<ProductModel>.from(json["the_best"]!.map((x) => x)),
//         products: json["products"] == null
//             ? []
//             : List<ProductModel>.from(json["products"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "the_best":
//             theBest == null ? [] : List<dynamic>.from(theBest!.map((x) => x)),
//         "products":
//             products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
//       };
// }


// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

class ProductModel {
  final ProductDataModel? data;
  final String? message;
  final int? code;

  ProductModel({
    this.data,
    this.message,
    this.code,
  });

  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    data: json["data"] == null ? null : ProductDataModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class ProductDataModel {
  final List<ProductItemModel>? theBest;
  final List<ProductItemModel>? products;

  ProductDataModel({
    this.theBest,
    this.products,
  });

  factory ProductDataModel.fromRawJson(String str) => ProductDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDataModel.fromJson(Map<String, dynamic> json) => ProductDataModel(
    theBest: json["the_best"] == null ? [] : List<ProductItemModel>.from(json["the_best"]!.map((x) => ProductItemModel.fromJson(x))),
    products: json["products"] == null ? [] : List<ProductItemModel>.from(json["products"]!.map((x) => ProductItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "the_best": theBest == null ? [] : List<dynamic>.from(theBest!.map((x) => x.toJson())),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class ProductItemModel {
  final int? id;
  final String? name;
  final int? price;
  final int? priceAfterDiscount;
  final String? image;

  ProductItemModel({
    this.id,
    this.name,
    this.price,
    this.priceAfterDiscount,
    this.image,
  });

  factory ProductItemModel.fromRawJson(String str) => ProductItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductItemModel.fromJson(Map<String, dynamic> json) => ProductItemModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    priceAfterDiscount: json["price_after_discount"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "price_after_discount": priceAfterDiscount,
    "image": image,
  };
}

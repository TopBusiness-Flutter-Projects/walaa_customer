
import 'dart:convert';

ProviderListModel providerModelFromJson(String str) => ProviderListModel.fromJson(json.decode(str));

String providerModelToJson(ProviderListModel data) => json.encode(data.toJson());

class ProviderListModel {
  ProviderListModel({
     this.data,
     this.message,
     this.code,
  });

  final List<ProviderModel>? data;
  final String? message;
  final int? code;

  factory ProviderListModel.fromJson(Map<String, dynamic> json) => ProviderListModel(
    data: List<ProviderModel>.from(json["data"].map((x) => ProviderModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class ProviderModel {
  ProviderModel({
     this.id,
     this.name,
     this.phone,
    this.email,
     this.image,
     this.categories,
  });

  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  List<CategoryModel>? categories;

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    categories: List<CategoryModel>.from(json["categories"].map((x) => CategoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "image": image,
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class CategoryModel {
  CategoryModel({
    this.id,
    this.categoryName,
    this.image,
  });

  int? id;
  String? categoryName;
  String? image;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"]??'',
    categoryName: json["name"],
    image: json["image"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": categoryName,
    "image": image,
  };
}

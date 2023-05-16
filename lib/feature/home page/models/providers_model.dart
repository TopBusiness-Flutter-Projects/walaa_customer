
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
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? image;
  final List<CategoryModel>? categories;
  final String? description;
  final int? rate;
  final MyRate? myRate;

  ProviderModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.categories,
    this.description,
    this.rate,
    this.myRate,
  });

  factory ProviderModel.fromRawJson(String str) => ProviderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    categories: json["categories"] == null ? [] : List<CategoryModel>.from(json["categories"]!.map((x) => CategoryModel.fromJson(x))),
    description: json["description"],
    rate: json["rate"],
    myRate: json["my_rate"] == null ? null : MyRate.fromJson(json["my_rate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "image": image,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "description": description,
    "rate": rate,
    "my_rate": myRate?.toJson(),
  };
}

class MyRate {
  final int? id;
  final String? value;
  final String? comment;
  final int? clientId;
  final int? providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MyRate({
    this.id,
    this.value,
    this.comment,
    this.clientId,
    this.providerId,
    this.createdAt,
    this.updatedAt,
  });

  factory MyRate.fromRawJson(String str) => MyRate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyRate.fromJson(Map<String, dynamic> json) => MyRate(
    id: json["id"],
    value: json["value"],
    comment: json["comment"],
    clientId: json["client_id"],
    providerId: json["provider_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "comment": comment,
    "client_id": clientId,
    "provider_id": providerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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

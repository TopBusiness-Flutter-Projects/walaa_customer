// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import '../../feature/home page/models/providers_model.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final HomeDataModel? data;
  final String? message;
  final int? code;

  HomeModel({
    this.data,
    this.message,
    this.code,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    data: json["data"] == null ? null : HomeDataModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class HomeDataModel {
  final List<ProviderModel>? theBestProvider;
  final List<ProviderModel>? providers;
  final List<SliderModel>? sliders;

  HomeDataModel({
    this.theBestProvider,
    this.providers,
    this.sliders,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    theBestProvider: json["the_best_provider"] == null ? [] : List<ProviderModel>.from(json["the_best_provider"]!.map((x) => ProviderModel.fromJson(x))),
    providers: json["providers"] == null ? [] : List<ProviderModel>.from(json["providers"]!.map((x) => ProviderModel.fromJson(x))),
    sliders: json["sliders"] == null ? [] : List<SliderModel>.from(json["sliders"]!.map((x) => SliderModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "the_best_provider": theBestProvider == null ? [] : List<dynamic>.from(theBestProvider!.map((x) => x.toJson())),
    "providers": providers == null ? [] : List<dynamic>.from(providers!.map((x) => x.toJson())),
    "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toJson())),
  };
}



class SliderModel {
  final int? id;
  final String? image;

  SliderModel({
    this.id,
    this.image,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

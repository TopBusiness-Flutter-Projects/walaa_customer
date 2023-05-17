import '../../../core/models/status_resspons.dart';
import '../../home page/models/providers_model.dart';

class CategoryDataModel {
  List<CategoryModel> data=[];
  late StatusResponse status;


  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];

      json['data'].forEach((v) {
        data.add(new CategoryModel.fromJson(v));
      });
    }
    status = StatusResponse.fromJson(json);
  }

}
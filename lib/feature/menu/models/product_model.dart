class ProductModel {
  int? id;
  String? name;
  String? name_ar;
  String? name_en;
  int? price;
  String? image;
  int quantity = 1;

  int? category_id;

  ProductModel({this.id, this.name, this.price, this.image, this.quantity = 1});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category_id = json['category_id']??0;
    name = json['name'] ?? "";
    name_ar = json['name_ar'] ?? "";
    name_en = json['name_en'] ?? "";
    price = json['price'];
    image = json['image'];
    quantity = json['quantity'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ProductModel = new Map<String, dynamic>();
    ProductModel['id'] = this.id;
    ProductModel['category_id'] = this.category_id;
    ProductModel['name'] = this.name;
    ProductModel['name_ar'] = this.name_ar;
    ProductModel['name_en'] = this.name_en;
    ProductModel['price'] = this.price;
    ProductModel['image'] = this.image;
    ProductModel['quantity'] = this.quantity;
    return ProductModel;
  }
}

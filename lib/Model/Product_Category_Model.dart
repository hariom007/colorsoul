// To parse this JSON data, do
//
//     final productCategoryModel = productCategoryModelFromJson(jsonString);

import 'dart:convert';

List<ProductCategoryModel> productCategoryModelFromJson(String str) => List<ProductCategoryModel>.from(json.decode(str).map((x) => ProductCategoryModel.fromJson(x)));

String productCategoryModelToJson(List<ProductCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategoryModel {
  ProductCategoryModel({
    this.catId,
    this.name,
    this.image,
  });

  String catId;
  String name;
  String image;

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
    catId: json["cat_id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "name": name,
    "image": image,
  };
}

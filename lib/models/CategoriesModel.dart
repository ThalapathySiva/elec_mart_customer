import 'dart:convert';

class CategoriesModel {
  final String name;
  final String image;

  CategoriesModel({
    this.image,
    this.name,
  });

  factory CategoriesModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoriesModel(
        name: json['type'], image: jsonDecode(json['image'])[0]);
  }
}

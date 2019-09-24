import 'dart:convert';

class CartItemModel {
  final String name;
  final String id;
  final double price;
  final List imageURL;

  CartItemModel({this.name, this.id, this.price, this.imageURL});

  factory CartItemModel.fromJson(Map<dynamic, dynamic> json) {
    return CartItemModel(
        name: json['name'],
        id: json['id'],
        price: json['sellingPrice'].toDouble(),
        imageURL: jsonDecode(json['imageUrl']));
  }
}

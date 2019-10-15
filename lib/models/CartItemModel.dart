import 'dart:convert';

import 'package:elec_mart_customer/models/InventoryItemModel.dart';

import 'VendorModel.dart';

class CartItemModel extends InventoryItemModel {
  final String name;
  final String id;
  final double price;
  final List imageURL;

  final double originalPrice;
  final double sellingPrice;
  final String description;
  final double inStock;
  final String category;
  final DateTime date;
  final VendorModel vendor;
  final List images;

  CartItemModel(
      {this.name,
      this.id,
      this.price,
      this.imageURL,
      this.images,
      this.vendor,
      this.originalPrice,
      this.date,
      this.sellingPrice,
      this.description,
      this.category,
      this.inStock});

  factory CartItemModel.fromJson(Map<dynamic, dynamic> json) {
    return CartItemModel(
        name: json['name'],
        id: json['id'],
        price: json['sellingPrice'].toDouble(),
        imageURL: jsonDecode(json['imageUrl']),
        description: json['description'],
        originalPrice: json['originalPrice'].toDouble(),
        sellingPrice: json['sellingPrice'].toDouble(),
        category: json['category'],
        date: DateTime.fromMicrosecondsSinceEpoch(
          int.parse(json['date']) * 1000,
        ),
        images: jsonDecode(json['imageUrl']),
        inStock: json['inStock'].toDouble(),
        vendor: VendorModel?.fromJson(json['vendor']));
  }
}

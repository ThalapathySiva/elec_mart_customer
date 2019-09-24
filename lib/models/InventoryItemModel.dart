import 'dart:convert';

import 'package:elec_mart_customer/models/VendorModel.dart';

class InventoryItemModel {
  final String name;
  final String id;
  final double originalPrice;
  final double sellingPrice;
  final String description;
  final double inStock;
  final String category;
  final DateTime date;
  final VendorModel vendor;
  final List images;

  InventoryItemModel(
      {this.images,
      this.vendor,
      this.originalPrice,
      this.date,
      this.sellingPrice,
      this.description,
      this.name,
      this.id,
      this.category,
      this.inStock});

  factory InventoryItemModel.fromJson(Map<dynamic, dynamic> json) {
    return InventoryItemModel(
        name: json['name'],
        id: json['id'],
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

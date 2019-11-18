import 'dart:convert';

import 'package:elec_mart_customer/models/VendorModel.dart';

class InventoryItemModel {
  final String name;
  final String id;
  final double originalPrice;
  final double sellingPrice;
  final String description;
  final double inStock;
  final double height;
  final bool deleted;
  final double breadth;
  final double length;
  final String category;
  final DateTime date;
  final VendorModel vendor;
  final List images;

  InventoryItemModel(
      {this.images,
      this.length,
      this.breadth,
      this.deleted,
      this.height,
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
        originalPrice: json['originalPrice'] != null
            ? double.parse(json['originalPrice'].toString())
            : null,
        sellingPrice: json['sellingPrice'] != null
            ? double.parse(json['sellingPrice'].toString())
            : null,
        category: json['category'],
        length: json['length'] != null
            ? double.parse(json['length'].toString())
            : null,
        breadth: json['breadth'] != null
            ? double.parse(json['breadth'].toString())
            : null,
        height: json['height'] != null
            ? double.parse(json['height'].toString())
            : null,
        deleted: json['deleted'] == false ? false : true,
        date: DateTime.fromMicrosecondsSinceEpoch(
          int.parse(json['date']) * 1000,
        ),
        images: jsonDecode(json['imageUrl']),
        inStock: json['inStock']?.toDouble(),
        vendor: json['vendor'] == null
            ? null
            : VendorModel?.fromJson(json['vendor']));
  }
}

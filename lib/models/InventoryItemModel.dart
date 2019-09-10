import 'package:elec_mart_customer/models/VendorModel.dart';

class InventoryItemModel {
  final String name;
  final String id;
  final double originalPrice;
  final double sellingPrice;
  final String description;
  final double inStock;
  final String category;
  final String imageURL;
  final VendorModel vendor;

  InventoryItemModel(
      {this.vendor,
      this.originalPrice,
      this.sellingPrice,
      this.description,
      this.imageURL,
      this.name,
      this.id,
      this.category,
      this.inStock});

  factory InventoryItemModel.fromJson(Map<dynamic, dynamic> json) {
    return InventoryItemModel(
        name: json['name'],
        id: json['id'],
        description: json['description'],
        imageURL: json['imageUrl'],
        originalPrice: json['originalPrice'].toDouble(),
        sellingPrice: json['sellingPrice'].toDouble(),
        category: json['category'],
        inStock: json['inStock'].toDouble(),
        vendor: VendorModel?.fromJson(json['vendor']));
  }
}

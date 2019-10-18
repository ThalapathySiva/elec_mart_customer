import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/models/VendorModel.dart';

class OfferModel {
  final String id;
  final List<InventoryItemModel> inventories;
  final String image;
  final VendorModel vendorModel;

  OfferModel({this.vendorModel, this.id, this.inventories, this.image});

  factory OfferModel.fromJson(Map<dynamic, dynamic> json) {
    List inventory = json['inventories'];
    return OfferModel(
        id: json['id'],
        inventories:
            inventory.map((f) => InventoryItemModel.fromJson(f)).toList(),
        image: json['posterImage'],
        vendorModel: json['vendor'] == null
            ? null
            : VendorModel?.fromJson(json['vendor']));
  }
}

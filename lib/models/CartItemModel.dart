import 'package:elec_mart_customer/models/InventoryItemModel.dart';

class CartItemModel extends InventoryItemModel {
  final String itemStatus;
  final String id;
  final InventoryItemModel inventory;

  CartItemModel({
    this.itemStatus,
    this.inventory,
    this.id,
  });

  factory CartItemModel.fromJson(Map<dynamic, dynamic> json) {
    return CartItemModel(
        id: json['id'],
        itemStatus: json["itemStatus"],
        inventory: InventoryItemModel.fromJson(json["inventory"]));
  }
}

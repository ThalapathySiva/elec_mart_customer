import 'dart:convert';

class VendorModel {
  final String shopPhotoUrl;
  final String storeName, adminPhonenumber;
  final Map address;

  VendorModel(
      {this.adminPhonenumber, this.shopPhotoUrl, this.storeName, this.address});

  factory VendorModel.fromJson(Map<dynamic, dynamic> json) {
    return VendorModel(
        shopPhotoUrl: json['shopPhotoUrl'],
        storeName: json['storeName'],
        adminPhonenumber: json['phoneNumber'],
        address: jsonDecode(json['address']));
  }
}

import 'dart:convert';

import 'package:elec_mart_customer/models/VendorModel.dart';

import 'AddressModel.dart';
import 'CartItemModel.dart';

class OrderModel {
  final String id;
  final String orderNo;
  final AddressModel address;
  final List<CartItemModel> cartItems;
  final String status;
  final DateTime datePlaced;
  final DateTime updatedDate;
  final String paymentMode;
  final double additionalCharge;
  final VendorModel vendor;
  final double totalPrice;
  final String cancelledReason;
  final int pinCode;
  final bool transactionSuccess;

  OrderModel(
      {this.pinCode,
      this.paymentMode,
      this.additionalCharge,
      this.id,
      this.totalPrice,
      this.cancelledReason,
      this.orderNo,
      this.address,
      this.cartItems,
      this.status,
      this.datePlaced,
      this.updatedDate,
      this.vendor,
      this.transactionSuccess});

  factory OrderModel.fromJson(Map<dynamic, dynamic> json) {
    List cartItems = (json['cartItems']);
    return OrderModel(
        id: json['id'],
        orderNo: json['orderNo'],
        cancelledReason: json['cancelledReason'],
        additionalCharge: json['additionalCharges'] != null
            ? double.parse(json['additionalCharges'].toString())
            : null,
        address: AddressModel.fromJson(jsonDecode(json['address'])),
        cartItems:
            cartItems.map((item) => CartItemModel.fromJson(item)).toList(),
        status: json['status'],
        datePlaced: DateTime.fromMicrosecondsSinceEpoch(
          int.parse(json['datePlaced']) * 1000,
        ),
        updatedDate: DateTime.fromMicrosecondsSinceEpoch(
          int.parse(json['updatedDate']) * 1000,
        ),
        totalPrice: json["totalPrice"] != null
            ? double.parse(json['totalPrice'].toString())
            : null,
        paymentMode: json["paymentMode"],
        transactionSuccess: json['transactionSuccess'],
        vendor: json["vendor"] != null
            ? VendorModel.fromJson(json['vendor'])
            : VendorModel());
  }
}

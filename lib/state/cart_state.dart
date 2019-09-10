import 'package:flutter/material.dart';

class CartState extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];
  double totalPrice = 0;

  CartState();

  void setCartItems(Map<String, dynamic> val) {
    _cartItems.add(val);
    totalPrice += val['price'];
    notifyListeners();
  }

  void removeCartItem(String id) {
    List<Map<String, dynamic>> cart = [];
    double newPrice = -1;
    _cartItems.forEach((item) {
      if (item["itemId"] == id && newPrice == -1) {
        newPrice = totalPrice - item["price"];
      } else {
        cart.add(item);
      }
    });
    totalPrice = newPrice;
    _cartItems = cart;
    notifyListeners();
  }

  List<Map<String, dynamic>> get cartItems => _cartItems;
}

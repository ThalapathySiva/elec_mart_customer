import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String userJwtToken = "";
  String userName = "";
  String phno = "";
  String searchText = "";
  AppState() {
    getToken();
  }

  Future getToken() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString('name') ?? "";
    final phonenumber = pref.getString('phone number');
    final tokenP = pref.getString('token') ?? "";
    if (tokenP != "") userJwtToken = tokenP;
    if (name != "") userName = name;
    if (phonenumber != "") phno = phonenumber;
  }

  void setToken(String val) {
    userJwtToken = val;
    notifyListeners();
  }

  void setPhoneNumber(String no) {
    phno = no;
    notifyListeners();
  }

  void setName(String name) {
    userName = name;
    notifyListeners();
  }

  void setsearchText(String text){
    searchText = text;
    notifyListeners();
  }

  String get jwtToken => userJwtToken;

  String get phoneNumber => phno;

  String get name => userName;

  String get getSearchText => searchText;
}

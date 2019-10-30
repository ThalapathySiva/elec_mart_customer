import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String userJwtToken = "";
  String userName = "";
  String phno = "";
  RangeValues rangeValues = RangeValues(0, 100000);
  String searchText = "";
  bool isExpanded = false;
  String sortType;
  bool filterApplied = false;
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

  void setSortType(String type) {
    sortType = type;
    filterApplied = true;
    notifyListeners();
  }

  void setIsExpanded(bool isExpanded) {
    isExpanded = isExpanded;
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

  void clearApp() {
    userJwtToken = "";
    userName = "";
    phno = "";
    searchText = "";
    notifyListeners();
  }

  void clearFilter() {
    searchText = "";
    sortType = "Price (low to high)";
    rangeValues = RangeValues(0, 100000);
    filterApplied = false;
    notifyListeners();
  }

  void setsearchText(String text) {
    searchText = text;
    filterApplied = true;
    notifyListeners();
  }

  void setRangeValues(RangeValues r) {
    rangeValues = r;
    filterApplied = true;
    notifyListeners();
  }

  RangeValues get rangeValue => rangeValues;

  String get jwtToken => userJwtToken;

  String get phoneNumber => phno;

  String get name => userName;

  String get getSearchText => searchText;

  String get getsortType => sortType;

  bool get getIsExpanded => isExpanded;

  bool get getfilterApplied => filterApplied;
}

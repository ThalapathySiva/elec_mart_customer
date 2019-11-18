import 'package:elec_mart_customer/components/bottom_bar.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/cart.dart';
import 'package:elec_mart_customer/screens/orders.dart';
import 'package:elec_mart_customer/screens/profile_screen.dart';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class NavigateScreens extends StatefulWidget {
  final int selectedIndex;

  NavigateScreens({this.selectedIndex = 0});
  @override
  _NavigateScreensState createState() => _NavigateScreensState();
}

class _NavigateScreensState extends State<NavigateScreens> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: layout(),
      ),
      bottomNavigationBar: BottomBar(
        index: selectedIndex,
        icons: [
          FeatherIcons.home,
          FeatherIcons.shoppingCart,
          FeatherIcons.box,
          FeatherIcons.settings
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget layout() {
    switch (selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return Cart();
      case 2:
        return Orders();
      case 3:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          );
        });
  }
}

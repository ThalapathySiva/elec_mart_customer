import 'package:elec_mart_customer/components/bottom_bar.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/cart.dart';
import 'package:elec_mart_customer/screens/orders.dart';
import 'package:elec_mart_customer/screens/profile_screen.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class NavigateScreens extends StatefulWidget {
  @override
  _NavigateScreensState createState() => _NavigateScreensState();
}

class _NavigateScreensState extends State<NavigateScreens> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: layout(),
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
    ;
  }
}

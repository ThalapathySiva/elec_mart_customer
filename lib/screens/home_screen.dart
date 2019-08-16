import 'package:elec_mart_customer/components/filter_modal.dart';
import 'package:elec_mart_customer/components/horizontal_list_item.dart';
import 'package:elec_mart_customer/components/horizontal_new_item.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/components/vendor_detail_item.dart';
import 'package:elec_mart_customer/components/vertical_list_item.dart';
import 'package:elec_mart_customer/components/vertical_new_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
      bottomNavigationBar: BottomBar(
        index: selectedIndex,
        icons: [Icons.home, Icons.shopping_cart, Icons.ac_unit, Icons.settings],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _layout() {
    return ListView(padding: EdgeInsets.only(top: 50), children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            child: FilterModal(),
          ),
          PrimaryButtonWidget(
            buttonText: "Primary",
            onPressed: () {},
          ),
          SecondaryButton(
            buttonText: "Secondary",
            onPressed: () {},
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: VerticalListItem(
              name: "Apple iPhone X - 64 GB, Rose Gold",
              mrpPrice: "Rs. 194,500",
              currentPrice: "Rs. 4500",
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: HorizontalListItem(
              name: "Apple iPhone X - 64 GB, Rose Gold",
              currentPrice: "Rs. 4500",
              mrpPrice: "Rs. 194,500",
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: VendorDetail(
              name: "Vendor Name",
              address: "Vendor Address",
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: VerticalNewItem(
              name: "Apple iPhone X - 64 GB, Rose Gold",
              currentPrice: "Rs. 4500",
              mrpPrice: "Rs. 194,500",
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            child: HorizontalNewItem(
              name: "Apple iPhone X - 64 GB, Rose Gold",
              currentPrice: "Rs. 4500",
              mrpPrice: "Rs. 194,500",
            ),
          ),
        ],
      )
    ]);
  }
}

class BottomBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int index;
  List<Map<String, Object>> iconData;

  BottomBar({this.onTap, this.index, List<IconData> icons}) {
    this.iconData = icons
        .asMap()
        .map((index, icon) => MapEntry(index, {"index": index, "value": icon}))
        .values
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return bottomBar();
  }

  Widget bottomBar() {
    return Container(
      height: 70,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          onTap: onTap,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          items: iconData.map((icon) => barItem(icon)).toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem barItem(Map<String, Object> iconData) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(top: 2),
        padding: EdgeInsets.all(7),
        child: Icon(iconData['value'],
            color:
                iconData['index'] == index ? PRIMARY_COLOR : LIGHT_BLUE_COLOR),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: iconData['index'] == index
              ? LIGHT_BLUE_COLOR.withOpacity(0.03)
              : null,
        ),
      ),
      title: Container(),
    );
  }
}

import 'package:elec_mart_customer/components/filter_modal.dart';
import 'package:elec_mart_customer/components/horizontal_list_item.dart';
import 'package:elec_mart_customer/components/horizontal_new_item.dart';
import 'package:elec_mart_customer/components/vertical_list_item.dart';
import 'package:elec_mart_customer/components/vertical_new_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/item_detail.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(children: <Widget>[
        Positioned(
            top: 80,
            left: 10,
            right: 10,
            child: isGrid ? gridView() : listView()),
        Positioned(top: 90, right: 10, child: options()),
        Positioned(top: 0, child: FilterModal()),
      ]),
    );
  }

  Widget options() {
    return Row(
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          child: IconButton(
            onPressed: () {
              setState(() {
                isGrid = true;
              });
            },
            icon: Icon(FeatherIcons.grid),
            color: isGrid ? WHITE_COLOR : LIGHT_BLUE_COLOR,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
            color: isGrid ? PRIMARY_COLOR : LIGHT_BLUE_COLOR.withOpacity(0.03),
          ),
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
              color:
                  isGrid ? LIGHT_BLUE_COLOR.withOpacity(0.03) : PRIMARY_COLOR),
          child: IconButton(
            icon: Icon(FeatherIcons.server),
            padding: EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                isGrid = false;
              });
            },
            color: isGrid ? LIGHT_BLUE_COLOR : WHITE_COLOR,
          ),
        )
      ],
    );
  }

  Widget gridView() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: height - 160,
        width: width,
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.73,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetail()),
                  );
                },
                child: VerticalListItem(
                  name: "Apple iPhone X - 64 GB, Rose Gold ",
                  mrpPrice: "10000",
                  currentPrice: "3600",
                ));
          },
        ));
  }


  Widget listView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 160,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 10),
        padding: EdgeInsets.all(8.0),
        itemCount: 50,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ItemDetail()));
            },
            child: HorizontalListItem(
              name: "Apple iPhone X - 64 GB, Rose Gold",
              mrpPrice: "10000",
              currentPrice: "3600",
            ),
          );
        },
      ),
    );
  }
}

import 'package:elec_mart_customer/components/filter_modal.dart';
import 'package:elec_mart_customer/components/horizontal_list_item.dart';
import 'package:elec_mart_customer/components/vertical_list_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/screens/item_detail.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'graphql/getAllInventory.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;
  int selectedIndex = 0;
  List<dynamic> categories = ["All"];
  String query = "";
  String selectedCategory = "All";
  String name = "";
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
        Positioned(top: 80, left: 10, right: 10, child: getInventoryQuery()),
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

  Widget gridView(List<InventoryItemModel> inventories) {
    if (inventories.length == 0) {
      return Center(
          child: Container(
              child: Text("No item found...",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold))));
    }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: height - 160,
        width: width,
        child: GridView.builder(
          itemCount: inventories.length,
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
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemDetail(inventory: inventories[index])),
                  );
                },
                child: VerticalListItem(
                  id: inventories[index].id,
                  imageURL: inventories[index].imageURL,
                  name: inventories[index].name,
                  mrpPrice: inventories[index].originalPrice.toString(),
                  currentPrice: inventories[index].sellingPrice.toString(),
                ));
          },
        ));
  }

  Widget listView(List<InventoryItemModel> inventories) {
    if (inventories.length == 0) {
      return Center(
          child: Container(
              child: Text("No item found...",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold))));
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height - 160,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 10),
        padding: EdgeInsets.all(8.0),
        itemCount: inventories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ItemDetail(inventory: inventories[index])));
            },
            child: HorizontalListItem(
              id: inventories[index].id,
              imageURL: inventories[index].imageURL,
              name: inventories[index].name,
              mrpPrice: inventories[index].originalPrice.toString(),
              currentPrice: inventories[index].sellingPrice.toString(),
            ),
          );
        },
      ),
    );
  }

  Widget getInventoryQuery({bool category = false}) {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: getAllInventory,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
        pollInterval: 2,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null && result.data['getAllInventory'] != null) {
          List inventoryList = result.data['getAllInventory']['inventory'];
          var inventories;
          if (inventoryList != null) {
            inventories = inventoryList
                .map((item) => InventoryItemModel.fromJson(item))
                .toList();

            categories =
                inventories.map((item) => item.category).toSet().toList();
          }
          return category
              ? categoriesComponents(["All", ...categories], context)
              : _items(inventories);
        }
        return Container();
      },
    );
  }

  categoriesComponents(List<String> list, BuildContext context) {}
  Widget _items(List<InventoryItemModel> inventories) {
    if (inventories == null) return Container();
    return isGrid ? gridView(inventories) : listView(inventories);
  }
}

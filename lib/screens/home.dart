import 'package:elec_mart_customer/components/filter_modal.dart';
import 'package:elec_mart_customer/components/horizontal_list_item.dart';
import 'package:elec_mart_customer/components/horizontal_new_item.dart';
import 'package:elec_mart_customer/components/vertical_list_item.dart';
import 'package:elec_mart_customer/components/vertical_new_item.dart';
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
  String sortType = "Price (low to high)";
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
        Positioned(top: 80, child: getInventoryQuery()),
        Positioned(top: 90, right: 10, child: options()),
        Positioned(
            top: 0,
            child: FilterModal(
              sortType: sortType,
              onItemChange: (val) {
                setState(() {
                  sortType = val;
                });
              },
              selectedCategory: selectedCategory,
              onCategoryChange: (val) {
                setState(() {
                  selectedCategory = val;
                });
              },
            )),
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
    final appState = Provider.of<AppState>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (inventories.length == 0) {
      return Container(
        height: height,
        width: width,
        child: Center(
          child: Text(
            "No item found...",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: PRIMARY_COLOR),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final filteredInventory = inventories
        .where((item) =>
            item.name
                .toLowerCase()
                .contains(appState.getSearchText.toLowerCase()) &&
            (item.category == selectedCategory || selectedCategory == "All"))
        .toList();

    return Container(
        height: height - 150,
        width: width,
        child: GridView.builder(
          itemCount: filteredInventory.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ItemDetail(inventory: filteredInventory[index])),
                    );
                  },
                  child: DateTime.now()
                              .difference(inventories[index].date)
                              .inDays <
                          7
                      ? VerticalNewItem(
                          id: filteredInventory[index].id,
                          imageURL: filteredInventory[index].images,
                          name: filteredInventory[index].name,
                          mrpPrice:
                              filteredInventory[index].originalPrice.toString(),
                          currentPrice:
                              filteredInventory[index].sellingPrice.toString(),
                        )
                      : VerticalListItem(
                          id: filteredInventory[index].id,
                          imageURL: filteredInventory[index].images,
                          name: filteredInventory[index].name,
                          mrpPrice:
                              filteredInventory[index].originalPrice.toString(),
                          currentPrice:
                              filteredInventory[index].sellingPrice.toString(),
                        )),
            );
          },
        ));
  }

  Widget listView(List<InventoryItemModel> inventories) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (inventories.length == 0) {
      return Container(
        height: height,
        width: width,
        child: Center(
          child: Text(
            "No item found...",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: PRIMARY_COLOR),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return SizedBox(
      height: height - 160,
      width: width,
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
            child: DateTime.now().difference(inventories[index].date).inDays < 7
                ? HorizontalNewItem(
                    id: inventories[index].id,
                    imageURL: inventories[index].images,
                    name: inventories[index].name,
                    mrpPrice: inventories[index].originalPrice.toString(),
                    currentPrice: inventories[index].sellingPrice.toString(),
                  )
                : HorizontalListItem(
                    id: inventories[index].id,
                    imageURL: inventories[index].images,
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
          List<InventoryItemModel> inventories;
          if (inventoryList != null) {
            inventories = inventoryList
                .map((item) => InventoryItemModel.fromJson(item))
                .toList();
            if (sortType == 'Price (low to high)') {
              inventories
                  .sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
            }
            if (sortType == 'Price (high to low)') {
              inventories
                  .sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
            }

            inventories = inventories
                .where((inventory) =>
                    appState.rangeValue.start <= inventory.sellingPrice &&
                    appState.rangeValue.end >= inventory.sellingPrice)
                .toList();

            if (sortType == 'Newest') {
              inventories.sort((a, b) => b.date.compareTo(a.date));
            }
          }
          return _items(inventories);
        }
        return Container();
      },
    );
  }

  Widget _items(List<InventoryItemModel> inventories) {
    if (inventories == null) return Container();
    return isGrid ? gridView(inventories) : listView(inventories);
  }
}

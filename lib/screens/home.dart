import 'package:carousel_pro/carousel_pro.dart';
import 'package:elec_mart_customer/components/filter_modal.dart';
import 'package:elec_mart_customer/components/horizontal_list_item.dart';
import 'package:elec_mart_customer/components/horizontal_new_item.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/components/vertical_list_item.dart';
import 'package:elec_mart_customer/components/vertical_new_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/models/OfferModel.dart';
import 'package:elec_mart_customer/screens/edit_address.dart';
import 'package:elec_mart_customer/screens/graphql/can_ship.dart';
import 'package:elec_mart_customer/screens/graphql/get_posters.dart';
import 'package:elec_mart_customer/screens/item_detail.dart';
import 'package:elec_mart_customer/screens/offer_screen.dart';
import 'package:elec_mart_customer/screens/orders.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'graphql/getAllInventory.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGrid = true;
  String selectedCategory = "All";
  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _layout());
  }

  Widget _layout() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: canShipQuery(),
    );
  }

  Widget weDontServeTHisArea() {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 50),
              Image.asset("assets/images/cactus.png", height: 256, width: 256),
              text("We don't here yet !", 30, PRIMARY_COLOR.withOpacity(0.3),
                  false),
              SizedBox(height: 20),
              Text(
                "Why don't you explore a different location?",
                style: TextStyle(
                    fontSize: 18,
                    color: PRIMARY_COLOR.withOpacity(0.3),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              SecondaryButton(
                buttonText: "Try Changing Location",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditAddress(showBackButton: true)));
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget searchField() {
    final appState = Provider.of<AppState>(context);
    if (appState.getSearchText == "") searchTextController.clear();
    return CustomTextField(
      controller: searchTextController,
      labelText: "Search for items",
      onChanged: (val) {
        appState.setsearchText(val);
      },
    );
  }

  Widget options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    final height = MediaQuery.of(context).size.height - 55;
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

    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
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
            onTap: filteredInventory[index].inStock <= 0
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ItemDetail(inventory: filteredInventory[index]),
                      ),
                    );
                  },
            child: DateTime.now().difference(inventories[index].date).inDays < 7
                ? VerticalNewItem(
                    outOfStock: filteredInventory[index].inStock <= 0,
                    id: filteredInventory[index].id,
                    imageURL: filteredInventory[index].images,
                    name: filteredInventory[index].name,
                    mrpPrice: filteredInventory[index].originalPrice.toString(),
                    currentPrice:
                        filteredInventory[index].sellingPrice.toString(),
                  )
                : VerticalListItem(
                    outOfStock: filteredInventory[index].inStock <= 0,
                    id: filteredInventory[index].id,
                    imageURL: filteredInventory[index].images,
                    name: filteredInventory[index].name,
                    mrpPrice: filteredInventory[index].originalPrice.toString(),
                    currentPrice:
                        filteredInventory[index].sellingPrice.toString(),
                  ),
          ),
        );
      },
    );
  }

  Widget listView(List<InventoryItemModel> inventories) {
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
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      padding: EdgeInsets.all(8.0),
      itemCount: filteredInventory.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: filteredInventory[index].inStock <= 0
              ? null
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ItemDetail(inventory: filteredInventory[index])));
                },
          child: DateTime.now()
                      .difference(filteredInventory[index].date)
                      .inDays <
                  7
              ? HorizontalNewItem(
                  outOfStock: filteredInventory[index].inStock <= 0,
                  id: filteredInventory[index].id,
                  imageURL: filteredInventory[index].images,
                  name: filteredInventory[index].name,
                  mrpPrice: filteredInventory[index].originalPrice.toString(),
                  currentPrice:
                      filteredInventory[index].sellingPrice.toString(),
                )
              : HorizontalListItem(
                  outOfStock: filteredInventory[index].inStock <= 0,
                  id: filteredInventory[index].id,
                  imageURL: filteredInventory[index].images,
                  name: filteredInventory[index].name,
                  mrpPrice: filteredInventory[index].originalPrice.toString(),
                  currentPrice:
                      filteredInventory[index].sellingPrice.toString(),
                ),
        );
      },
    );
  }

  Widget filtersApplied() {
    final appState = Provider.of<AppState>(context);
    return Container(
        child: Row(
          children: <Widget>[
            text("Filters applied", 16, PRIMARY_COLOR, true),
            IconButton(
                onPressed: () {
                  appState.clearFilter();
                },
                icon: Icon(
                  FeatherIcons.x,
                  size: 16,
                  color: PRIMARY_COLOR,
                ))
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: GREY_COLOR));
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
            if (appState.getsortType == 'Price (low to high)') {
              inventories
                  .sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
            }
            if (appState.getsortType == 'Price (high to low)') {
              inventories
                  .sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
            }

            inventories = inventories
                .where((inventory) =>
                    appState.rangeValue.start <= inventory.sellingPrice &&
                    appState.rangeValue.end >= inventory.sellingPrice)
                .toList();

            if (appState.getsortType == 'Newest') {
              inventories.sort((a, b) => b.date.compareTo(a.date));
            }
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 120),
            child: ListView(
              physics: ScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      appState.getfilterApplied
                          ? filtersApplied()
                          : Container(),
                      options()
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 10),
                    child: searchField()),
                getPostersQuery(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(height: 10, thickness: 1)),
                _items(inventories)
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget getPostersQuery() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: posters,
        pollInterval: 10,
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
      ),
      builder: (result, {refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));

        if (result.data != null &&
            result.data["getPosters"] != null &&
            result.data["getPosters"].length != 0) {
          final List poster = result.data["getPosters"];
          final posters = poster.map((f) => OfferModel.fromJson(f)).toList();
          return Container(
            margin: EdgeInsets.all(16),
            height: 150,
            child: Carousel(
              onImageTap: (index) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OfferScreen(
                              inventories: posters[index].inventories,
                              vendor: posters[index].vendorModel,
                              image: posters[index].image,
                            )));
              },
              images: posters
                  .map((f) => Image.network(
                        f.image,
                        fit: BoxFit.fitWidth,
                      ))
                  .toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.lightGreenAccent,
              indicatorBgPadding: 5.0,
              borderRadius: true,
              moveIndicatorFromBottom: 180.0,
              noRadiusForIndicator: true,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget canShipQuery() {
    final appState = Provider.of<AppState>(context);

    return Query(
      options: QueryOptions(
        document: canShip,
        pollInterval: 3,
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
      ),
      builder: (result, {refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data["canShipItem"] != null) {
          bool canShiptoCustomer = result.data["canShipItem"];
          if (canShiptoCustomer) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: <Widget>[
                Positioned(top: 50, child: getInventoryQuery()),
                Positioned(
                    top: 0,
                    child: FilterModal(
                      selectedCategory: selectedCategory,
                      onCategoryChange: (val) {
                        setState(() {
                          selectedCategory = val;
                        });
                      },
                    )),
              ]),
            );
          } else {
            return weDontServeTHisArea();
          }
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

import 'package:elec_mart_customer/components/rating.dart';

import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/components/vendor_detail_item.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/screens/add_review.dart';
import 'package:elec_mart_customer/screens/ask_questions.dart';
import 'package:elec_mart_customer/screens/orders.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:elec_mart_customer/state/cart_state.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:provider/provider.dart';

import 'graphql/getReviews.dart';

class ItemDetail extends StatefulWidget {
  final String description, name, vendorName, vendorAddress, callNumber;
  final InventoryItemModel inventory;

  ItemDetail(
      {this.description,
      this.name,
      this.vendorName,
      this.vendorAddress,
      this.callNumber,
      this.inventory});
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  double averageRating = 0;

  GlobalKey<ScaffoldState> scaffold_state = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold_state,
      body: layout(),
    );
  }

  Widget layout() {
    return Column(
      children: <Widget>[
        AppTitleWidget(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            children: <Widget>[
              Hero(
                tag: widget.inventory.id,
                child: SizedBox(
                    height: 400.0,
                    width: 350.0,
                    child: Carousel(
                      images: widget.inventory.images
                          .map((f) => Image.network(
                                f,
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
                    )),
              ),
              SizedBox(height: 10),
              Text(
                widget.inventory.name,
                style: TextStyle(color: PRIMARY_COLOR, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              descp(),
              SizedBox(height: 10),
              vendorDetails(),
              SizedBox(height: 10),
              giveRating(),
              SizedBox(height: 10),
              avgRating(),
              SizedBox(height: 10),
              getCustomerReviews(),
              SizedBox(height: 10),
              Divider(height: 10, thickness: 1),
              questions(),
              SizedBox(height: 10),
              askQuestions(),
            ],
          ),
        ),
        bottom(),
      ],
    );
  }

  Widget descp() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Item Description",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10),
          Text(
            widget.inventory.description,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget vendorDetails() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sold By",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10),
          VendorDetail(
            storeImage: widget.inventory.vendor.shopPhotoUrl,
            name: widget.inventory.vendor.storeName,
            address: widget.inventory.vendor.address['addressLine'] +
                "\n" +
                widget.inventory.vendor.address['city'],
          ),
          Divider(height: 10, thickness: 1),
          SizedBox(height: 10),
          Text(
            "Item Reviews",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget giveRating() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddReview(inventory: widget.inventory)));
      },
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            boxShadow: [
              BoxShadow(
                color: PRIMARY_COLOR,
                blurRadius: 5.0,
              ),
            ],
            border: Border.all(color: PRIMARY_COLOR.withOpacity(0.13)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RatingStar(
                  borderColor: WHITE_COLOR,
                  color: WHITE_COLOR,
                  size: 20.0,
                  rating: 0,
                ),
                SizedBox(height: 10),
                Text(
                  "You’ve purchased this item.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: WHITE_COLOR),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Tap here to provide a review.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: WHITE_COLOR),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            Icon(Icons.rate_review, color: WHITE_COLOR, size: 46)
          ],
        ),
      ),
    );
  }

  Widget askQuestions() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AskQuestion()));
      },
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            boxShadow: [
              BoxShadow(
                color: PRIMARY_COLOR,
                blurRadius: 5.0,
              ),
            ],
            border: Border.all(color: PRIMARY_COLOR.withOpacity(0.13)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  "Need more help?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: WHITE_COLOR),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Tap here to ask a question.",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: WHITE_COLOR),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            Icon(Icons.help_outline, color: WHITE_COLOR, size: 46)
          ],
        ),
      ),
    );
  }

  Widget comments(QueryResult result) {
    return ListView.separated(
        separatorBuilder: (context, i) => Container(height: 10),
        shrinkWrap: true,
        itemCount: 2,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  border: Border.all(color: PRIMARY_COLOR.withOpacity(0.13)),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RatingStar(
                        borderColor: PRIMARY_COLOR,
                        color: PRIMARY_COLOR,
                        size: 16.0,
                        onratingChanged: (v) {
                          setState(() {
                            averageRating = v;
                          });
                        },
                        rating: averageRating,
                      ),
                      SizedBox(width: 10),
                      Text("${averageRating.toStringAsFixed(1)}/5",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: PRIMARY_COLOR)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Works very well, and looks even better. It’s been a few days since I purchased this and it works very well",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text("Sivaperumal K",
                        style: TextStyle(
                          fontSize: 14,
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ));
  }

  Widget questions() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("Customer Questions", 20, BLACK_COLOR, true),
          ListView.separated(
              separatorBuilder: (context, i) => Container(height: 10),
              shrinkWrap: true,
              itemCount: 2,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: PRIMARY_COLOR.withOpacity(0.13)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: <Widget>[
                        text(
                            "What is the waterproof grading of this product, can I use tempered glass on it?",
                            14,
                            PRIMARY_COLOR,
                            true),
                        SizedBox(height: 10),
                        Divider(height: 10, thickness: 1),
                        text("It is IP68. And yes, you can use tempered glass.",
                            14, BLACK_COLOR, true),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }

  Widget avgRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Avg. Rating",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: PRIMARY_COLOR)),
        Row(
          children: <Widget>[
            RatingStar(
              borderColor: PRIMARY_COLOR,
              color: PRIMARY_COLOR,
              size: 20.0,
              onratingChanged: (v) {
                setState(() {
                  averageRating = v;
                });
              },
              rating: averageRating,
            ),
            Text("${averageRating.toStringAsFixed(1)}/5",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR)),
          ],
        ),
      ],
    );
  }

  Widget bottom() {
    final cartState = Provider.of<CartState>(context);

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Rs " + widget.inventory.originalPrice.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.lineThrough,
                      color: RED_COLOR),
                ),
              ),
              Center(
                child: Text(
                  "Rs " + widget.inventory.sellingPrice.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 26,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              PrimaryButtonWidget(
                icon: FeatherIcons.shoppingCart,
                buttonText: "Buy now",
                onPressed: () {
                  // final snackBar =
                  //     SnackBar(content: Text('This item added to the cart !'));
                  // scaffold_state.currentState.showSnackBar(snackBar);
                  // cartState.setCartItems({
                  //   "name": widget.inventory.name,
                  //   "imageUrl": widget.inventory.images,
                  //   "itemId": widget.inventory.id,
                  //   "price": widget.inventory.sellingPrice
                  // });
                },
              ),
              TeritoryButton(
                text: "Add to cart",
                onpressed: () {
                  final snackBar =
                      SnackBar(content: Text('This item added to the cart !'));
                  scaffold_state.currentState.showSnackBar(snackBar);
                  cartState.setCartItems({
                    "name": widget.inventory.name,
                    "imageUrl": widget.inventory.images,
                    "itemId": widget.inventory.id,
                    "price": widget.inventory.sellingPrice
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getCustomerReviews() {
    final appState = Provider.of<AppState>(context);
    var queryOptions = QueryOptions(
      document: getReviews,
      fetchPolicy: FetchPolicy.noCache,
      context: {
        'headers': <String, String>{
          'Authorization': 'Bearer ${appState.jwtToken}',
        },
      },
      pollInterval: 1,
    );
    return Query(
      options: queryOptions,
      builder: (QueryResult result, {VoidCallback refetch}) {
        print(result.errors);

        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));

        if (result.data != null && result.data['getReviews'] != null) {
          return comments(result.data);
        }
        return Container();
      },
    );
  }
}

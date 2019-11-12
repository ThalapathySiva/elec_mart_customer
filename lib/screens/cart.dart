import 'dart:convert';
import 'package:elec_mart_customer/components/cart_item.dart';
import 'package:elec_mart_customer/components/dialog_style.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/screens/edit_address.dart';
import 'package:elec_mart_customer/screens/graphql/create_new_order.dart';
import 'package:elec_mart_customer/screens/nav_screens.dart';
import 'package:elec_mart_customer/screens/order_placed.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:elec_mart_customer/state/cart_state.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'graphql/getCustomerInfo.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isTickCreditCard = false;
  bool isTickCOD = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    final cartState = Provider.of<CartState>(context);
    if (cartState.cartItems.length == 0) {
      return whenCartEmpty();
    }
    return Container(
      child: ListView(
        children: <Widget>[
          listItems(),
          totalRow(),
          Container(height: 3, color: GREY_COLOR),
          getAddressQuery(),
          Container(height: 3, color: GREY_COLOR),
          paymentMode(),
          if (isTickCreditCard)
            Container(
              padding: EdgeInsets.only(left: 24, top: 10),
              child: Text(
                "* We recommend you to use UPI for Payment",
                style: TextStyle(
                    color: RED_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          if ((isTickCOD || isTickCreditCard) &&
              cartState.cartItems.length != 0)
            Container(
              padding: EdgeInsets.all(24),
              child: mutationComponent(),
            )
        ],
      ),
    );
  }

  Widget listItems() {
    final cartState = Provider.of<CartState>(context);

    return cartState.cartItems.length == 0
        ? Container(
            height: 200,
            child: Center(
                child: Text(
              "No Items found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          )
        : ListView.separated(
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(24),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            shrinkWrap: true,
            itemCount: cartState.cartItems.length,
            itemBuilder: (context, index) {
              return CartItem(
                  imageUrl: "${cartState.cartItems[index]["imageUrl"][0]}",
                  name: "${cartState.cartItems[index]["name"]}",
                  currentPrice: "${cartState.cartItems[index]["price"]}",
                  canDelete: true,
                  id: "${cartState.cartItems[index]["itemId"]}");
            },
          );
  }

  Widget totalRow() {
    final cartState = Provider.of<CartState>(context);

    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              text("Total", 16, BLACK_COLOR, true),
              text("Rs ${cartState.totalPrice}", 20, PRIMARY_COLOR, true)
            ],
          ),
          text(
              cartState.totalPrice > 1500
                  ? "Free Shipping"
                  : "(Shipping charge Rs 45)",
              16,
              RED_COLOR,
              true),
        ],
      ),
    );
  }

  Widget text(String title, double size, Color color, bool isBold) {
    return Text(
      "$title",
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : null),
    );
  }

  Widget whenCartEmpty() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(height: 50),
            Image.asset("assets/images/cactus.png", height: 256, width: 256),
            text("Your cart is empty!", 30, PRIMARY_COLOR.withOpacity(0.3),
                false),
            SizedBox(height: 20),
            Text(
              "Browse our collection and add items to the cart.",
              style: TextStyle(
                  fontSize: 18,
                  color: PRIMARY_COLOR.withOpacity(0.3),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            SecondaryButton(
              buttonText: "Browse store",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigateScreens(
                              selectedIndex: 0,
                            )));
              },
            )
          ],
        )
      ],
    );
  }

  Widget paymentMode() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Icon(FeatherIcons.dollarSign, size: 20),
            SizedBox(width: 10),
            text("Payment Mode", 16, BLACK_COLOR, true)
          ]),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                setState(() {
                  isTickCreditCard = true;
                  isTickCOD = false;
                });
              },
              child: paymentType(FeatherIcons.creditCard, "Credit/Debit Card",
                  isTickCreditCard)),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                setState(() {
                  isTickCOD = true;
                  isTickCreditCard = false;
                });
              },
              child: paymentType(
                  FeatherIcons.package, "Cash On Delivery", isTickCOD))
        ],
      ),
    );
  }

  Widget paymentType(IconData icon, String text, bool check) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(icon, size: 20),
          Text(text, style: TextStyle(color: PRIMARY_COLOR, fontSize: 16)),
          check
              ? Icon(
                  FeatherIcons.checkCircle,
                  size: 16,
                  color: PRIMARY_COLOR,
                )
              : Container(),
        ],
      ),
    );
  }

  Widget addressWidget(QueryResult result) {
    if (result.data == null ||
        result.data["getCustomerInfo"] == null ||
        result.data["getCustomerInfo"]["user"] == null ||
        result.data["getCustomerInfo"]["user"]["address"] == null) {
      return Container();
    }
    String addressString = result.data["getCustomerInfo"]["user"]["address"];
    Map address = jsonDecode(addressString);

    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FeatherIcons.truck),
                  SizedBox(width: 10),
                  text("Shipping Address", 16, BLACK_COLOR, true),
                ],
              ),
              SecondaryButton(
                buttonText: "Edit",
                icon: FeatherIcons.edit2,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditAddress(showBackButton: true)));
                },
              )
            ],
          ),
          text("${address["name"]}", 14, BLACK_COLOR, true),
          text("${address["addressLine"]}", 14, BLACK_COLOR, true),
          text("${address["city"]}", 14, BLACK_COLOR, true),
          text("${address["phoneNumber"]}", 14, BLACK_COLOR, true),
          text("${address["pinCode"]}", 14, BLACK_COLOR, true),
        ],
      ),
    );
  }

  Widget getAddressQuery() {
    final appState = Provider.of<AppState>(context);

    return Query(
      options: QueryOptions(
        document: getCustomerInfo,
        fetchPolicy: FetchPolicy.noCache,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        return result.loading
            ? Center(child: CupertinoActivityIndicator())
            : addressWidget(result);
      },
    );
  }

  Widget mutationComponent() {
    final cartState = Provider.of<CartState>(context);
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: createNewOrder,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.jwtToken}',
          },
        },
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return result.loading
            ? Center(child: CupertinoActivityIndicator())
            : PrimaryButtonWidget(
                buttonText:
                    isTickCOD ? "Proceed to Order" : "Proceed to Payment",
                onPressed: () {
                  runMutation({
                    "paymentMode":
                        isTickCOD ? "Cash On Delivery" : "Credit/Debit Card",
                    "cartItemIds": cartState.cartItems
                        .map((item) => item['itemId'])
                        .toList(),
                  });
                },
              );
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {
        if (resultData['createNewOrder']['error'] != null) {
          showDialog(
              context: context,
              builder: (context) => DialogStyle(
                  content: resultData['createNewOrder']['error']['message']));
        } else {
          final cartState = Provider.of<CartState>(context);
          final Map order = resultData["createNewOrder"]["orders"][0];
          if (isTickCreditCard) {
            cartState.clearCart();
            isTickCreditCard = false;
            isTickCOD = false;
            launch(
                "http://cezhop.herokuapp.com/paywithpaytm?orderId=${order["id"]}");
          } else {
            cartState.clearCart();
            isTickCreditCard = false;
            isTickCOD = false;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderPlaced(
                      isCOD: isTickCOD, totalPrice: order["totalPrice"])),
              (val) => false,
            );
          }
        }
      },
    );
  }
}

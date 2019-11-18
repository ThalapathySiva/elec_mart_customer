import 'package:elec_mart_customer/components/order_status_component.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/constants/strings.dart';
import 'package:elec_mart_customer/models/OrderModel.dart';
import 'package:elec_mart_customer/screens/order_detail.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'edit_address.dart';
import 'graphql/can_ship.dart';
import 'graphql/get_customer_orders.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24),
        child: canShipQuery(),
      ),
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
            return ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: text("Orders", 16, BLACK_COLOR, true)),
                    SizedBox(height: 20),
                    getCustomerOrdersQuery(),
                  ],
                ),
              ],
            );
          } else {
            return weDontServeTHisArea();
          }
        }

        return Container();
      },
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
              text("We don't deliver here yet !", 30,
                  PRIMARY_COLOR.withOpacity(0.3), false),
              SizedBox(height: 20),
              Text(
                "Soonly we will be.",
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

  Widget orderList(Map result) {
    List data = result["getCustomerOrders"]["orders"];
    var orders = [], previousOrders, activeOrders;
    if (data.length == 0) {
      return Container(
        child: Center(
          child: Text(
            "No order found...",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: PRIMARY_COLOR),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (data != null) {
      orders =
          data.map((f) => OrderModel.fromJson(f)).toList().reversed.toList();
      previousOrders = orders
          .where((f) => !((f.status == OrderStatuses.PLACED_BY_CUSTOMER ||
                  f.status == OrderStatuses.RECEIVED_BY_STORE ||
                  f.status == OrderStatuses.PICKED_UP) &&
              (f.transactionSuccess == true ||
                  f.paymentMode == "Cash On Delivery")))
          .toList();
      activeOrders = orders
          .where((f) =>
              (f.status == OrderStatuses.PLACED_BY_CUSTOMER ||
                  f.status == OrderStatuses.RECEIVED_BY_STORE ||
                  f.status == OrderStatuses.PICKED_UP) &&
              (f.transactionSuccess == true ||
                  f.paymentMode == "Cash On Delivery"))
          .toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (activeOrders != null && activeOrders.length != 0)
          Container(
            padding: EdgeInsets.only(left: 10),
            child: text("ACTIVE ORDERS", 12, PRIMARY_COLOR, true),
          ),
        SizedBox(height: 10),
        if (activeOrders != null && activeOrders.length != 0)
          activeOrdersList(activeOrders),
        SizedBox(height: 10),
        if (previousOrders != null && previousOrders.length != 0)
          Container(
            padding: EdgeInsets.only(left: 10),
            child: text("PREVIOUS ORDERS", 12, PRIMARY_COLOR, true),
          ),
        SizedBox(height: 10),
        if (previousOrders != null && previousOrders.length != 0)
          previousOrdersList(previousOrders),
      ],
    );
  }

  Widget activeOrdersList(List<OrderModel> orders) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderDetail(order: orders[index])));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: LIGHT_BLUE_COLOR, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: LIGHT_BLUE_COLOR.withOpacity(0.03)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  text("Order ID: BS${orders[index].orderNo}", 16, BLACK_COLOR,
                      true),
                  text(
                      orders[index].additionalCharge != 0
                          ? "Rs. ${orders[index].totalPrice + 45}"
                          : "Rs. ${orders[index].totalPrice}",
                      16,
                      PRIMARY_COLOR,
                      true)
                ],
              ),
              SizedBox(height: 5),
              text("${orders[index].cartItems.length} items", 14, BLACK_COLOR,
                  false),
              SizedBox(height: 10),
              OrderStatusIndicatorWidget(
                orderStatus: orders[index].status.toString().toUpperCase(),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  text("${orders[index].paymentMode}", 14, PRIMARY_COLOR, true),
                ],
              ),
              if (orders[index].paymentMode != "Cash On Delivery")
                Divider(thickness: 1, height: 10),
              if (orders[index].paymentMode != "Cash On Delivery")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (orders[index].paymentMode != "Cash On Delivery")
                      text(
                          orders[index].transactionSuccess
                              ? "Transaction Success"
                              : "Transaction Failed",
                          14,
                          orders[index].transactionSuccess
                              ? Colors.green
                              : Colors.red,
                          true),
                    Spacer(),
                    if (orders[index].transactionSuccess == false)
                      text("${orders[index].paymentMode}", 14, PRIMARY_COLOR,
                          true),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget previousOrdersList(List<OrderModel> orders) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          int cartItemsAvailable = orders[index]
              .cartItems
              .where((item) =>
                  item.inventory.inStock != null &&
                  item.inventory.inStock > 0 &&
                  !item.inventory.deleted)
              .toList()
              .length;
          return Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: LIGHT_BLUE_COLOR.withOpacity(0.03)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderDetail(order: orders[index])));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          text("Order ID: BS${orders[index].orderNo}", 16,
                              BLACK_COLOR, true),
                          text(
                              orders[index].additionalCharge != 0
                                  ? "Rs. ${orders[index].totalPrice + 45}"
                                  : "Rs. ${orders[index].totalPrice}",
                              16,
                              PRIMARY_COLOR,
                              true)
                        ],
                      ),
                      SizedBox(height: 5),
                      text("${orders[index].cartItems.length} items", 14,
                          BLACK_COLOR, false),
                      SizedBox(height: 10),
                      OrderStatusIndicatorWidget(
                        orderStatus: orders[index].status.toUpperCase(),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          text("${orders[index].paymentMode}", 14,
                              PRIMARY_COLOR, true),
                        ],
                      ),
                    ],
                  ),
                ),
                if (orders[index].paymentMode != "Cash On Delivery")
                  Divider(thickness: 1, height: 10),
                if (orders[index].paymentMode != "Cash On Delivery")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (orders[index].paymentMode != "Cash On Delivery")
                        text(
                            orders[index].transactionSuccess
                                ? "Transaction Success"
                                : "Transaction Failed",
                            14,
                            orders[index].transactionSuccess
                                ? Colors.green
                                : Colors.red,
                            true),
                      Spacer(),
                      if (orders[index].transactionSuccess == false &&
                          cartItemsAvailable == orders[index].cartItems.length)
                        tryAgain(orders[index].id)
                    ],
                  ),
              ],
            ),
          );
        });
  }

  Widget tryAgain(String id) {
    return InkWell(
      onTap: () {
        launch("http://cezhop.herokuapp.com/paywithpaytm?orderId=$id");
      },
      child: Row(
        children: <Widget>[
          text("Try Again", 14, PRIMARY_COLOR, true),
          Icon(
            Icons.keyboard_arrow_right,
            color: PRIMARY_COLOR,
          )
        ],
      ),
    );
  }

  Widget getCustomerOrdersQuery() {
    final appState = Provider.of<AppState>(context);
    var queryOptions = QueryOptions(
      document: getCustomerOrders,
      fetchPolicy: FetchPolicy.noCache,
      context: {
        'headers': <String, String>{
          'Authorization': 'Bearer ${appState.jwtToken}',
        },
      },
      pollInterval: 2,
    );
    return Query(
      options: queryOptions,
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null && result.data['getCustomerOrders'] != null) {
          return orderList(result.data);
        }
        return Container();
      },
    );
  }
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

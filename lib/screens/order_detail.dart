import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/cart_item.dart';
import 'package:elec_mart_customer/components/order_status_component.dart';
import 'package:elec_mart_customer/components/secondary_button.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/constants/strings.dart';
import 'package:elec_mart_customer/models/OrderModel.dart';
import 'package:elec_mart_customer/screens/item_detail.dart';
import 'package:elec_mart_customer/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'graphql/change_order_status.dart';
import 'nav_screens.dart';

class OrderDetail extends StatefulWidget {
  final OrderModel order;

  OrderDetail({this.order});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return Container(
      child: ListView(
        children: <Widget>[
          AppTitleWidget(),
          firstRow(),
          secondRow(),
          if (widget.order.paymentMode != "Cash On Delivery")
            Container(
                padding: EdgeInsets.only(right: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      text(
                          widget.order.transactionSuccess
                              ? "Transaction Success"
                              : "Transaction Failed",
                          14,
                          widget.order.transactionSuccess
                              ? Colors.green
                              : Colors.red,
                          true)
                    ])),
          firstColumn(),
          itemsInOrder(),
          address(),
          if ((widget.order.status.toUpperCase() ==
                      OrderStatuses.PLACED_BY_CUSTOMER ||
                  widget.order.status.toUpperCase() ==
                      OrderStatuses.RECEIVED_BY_STORE) &&
              (widget.order.transactionSuccess != false ||
                  widget.order.paymentMode == "Cash On Delivery"))
            mutationComponent()
        ],
      ),
    );
  }

  Widget firstRow() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          text("Order ID: BS${widget.order.orderNo}", 16, BLACK_COLOR, true),
          text("Rs. ${widget.order.totalPrice}", 24, PRIMARY_COLOR, true),
        ],
      ),
    );
  }

  Widget secondRow() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          text("ORDER STATUS", 12, PRIMARY_COLOR, true),
          OrderStatusIndicatorWidget(
            orderStatus: widget.order.status.toString().toUpperCase(),
          ),
        ],
      ),
    );
  }

  Widget firstColumn() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("${widget.order.status.split('_').join(" ").toLowerCase()}", 20,
              PRIMARY_COLOR, true),
          SizedBox(height: 5),
          text(
              StringResolver.getTextForOrderStatus(status: widget.order.status),
              14,
              BLACK_COLOR,
              false),
        ],
      ),
    );
  }

  Widget itemsInOrder() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("ITEMS IN ORDER", 12, PRIMARY_COLOR, true),
          SizedBox(height: 5),
          listItems()
        ],
      ),
    );
  }

  Widget listItems() {
    return ListView.separated(
      physics: ScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      shrinkWrap: true,
      itemCount: widget.order.cartItems.length,
      itemBuilder: (context, index) {
        print("no stock" +
            (widget.order.cartItems[index].inventory.inStock <= 0).toString());
        print(widget.order.cartItems[index].inventory.deleted);
        bool deleted = widget.order.cartItems[index].inventory.inStock <= 0 ||
            widget.order.cartItems[index].inventory.deleted;

        return InkWell(
          onTap: deleted
              ? null
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemDetail(
                                inventory:
                                    widget.order.cartItems[index].inventory,
                                description:
                                    widget.order.cartItems[index].description,
                                name: widget.order.cartItems[index].name,
                              )));
                },
          child: CartItem(
            itemStatus: "${widget.order.cartItems[index].itemStatus}",
            imageUrl: "${widget.order.cartItems[index].inventory.images[0]}",
            name: "${widget.order.cartItems[index].inventory.name}",
            currentPrice:
                "Rs. ${widget.order.cartItems[index].inventory.sellingPrice}",
          ),
        );
      },
    );
  }

  Widget address() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("SHIPPING ADDRESS", 12, PRIMARY_COLOR, true),
          SizedBox(height: 10),
          text("${widget.order.address.name}", 14, BLACK_COLOR, true),
          text("${widget.order.address.addressLine},", 14, BLACK_COLOR, true),
          text("${widget.order.address.city}", 14, BLACK_COLOR, true),
          text("${widget.order.address.phoneNumber}", 14, PRIMARY_COLOR, true),
          text("${widget.order.address.pinCode}", 14, PRIMARY_COLOR, true),
        ],
      ),
    );
  }

  Widget finalColumn(RunMutation runMutation) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Center(
        child: SecondaryButton(
          buttonText: "Cancel Order",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Are you sure you want to cancel this order ?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      runMutation(
                        {
                          "status": OrderStatuses.CANCELLED_BY_CUSTOMER,
                          "orderId": "${widget.order.id}"
                        },
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavigateScreens(selectedIndex: 2),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
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

  Widget mutationComponent() {
    final appState = Provider.of<AppState>(context);

    return Mutation(
      options: MutationOptions(
        document: changeOrder,
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
            : finalColumn(runMutation);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) async {},
    );
  }
}

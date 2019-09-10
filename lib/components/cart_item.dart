import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/state/cart_state.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String name, currentPrice;
  final bool canDelete;
  final String imageUrl;
  final String id;

  CartItem(
      {this.id,
      this.imageUrl,
      this.name,
      this.currentPrice,
      this.canDelete = false});

  @override
  Widget build(BuildContext context) {
    final cartState = Provider.of<CartState>(context);

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        color: GREY_COLOR,
      ),
      child: Row(
        children: <Widget>[
          Image.network(
            "$imageUrl",
            width: 80,
          ),
          Container(margin: EdgeInsets.only(left: 10)),
          Container(
            width: MediaQuery.of(context).size.width / 1.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                text(currentPrice, context, 18, PRIMARY_COLOR),
                if (canDelete)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        cartState.removeCartItem("$id");
                      },
                      icon: Icon(
                        FeatherIcons.trash2,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget text(String title, context, double size, Color colors) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Text(
        "$title",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 16,
          color: PRIMARY_COLOR,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

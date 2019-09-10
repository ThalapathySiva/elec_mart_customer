import 'package:elec_mart_customer/components/screen_indicator.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:elec_mart_customer/constants/strings.dart';
import 'package:flutter/material.dart';

class OrderStatusIndicatorWidget extends StatelessWidget {
  final String orderStatus;
  const OrderStatusIndicatorWidget({Key key, this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorsArray = [];
    switch (orderStatus) {
      case OrderStatuses.PLACED_BY_CUSTOMER:
        {
          colorsArray = [
            PRIMARY_COLOR,
            PRIMARY_COLOR.withOpacity(0.13),
            PRIMARY_COLOR.withOpacity(0.13),
            PRIMARY_COLOR.withOpacity(0.13)
          ];
          break;
        }
      case OrderStatuses.RECEIVED_BY_STORE:
        {
          colorsArray = [
            PRIMARY_COLOR,
            PRIMARY_COLOR,
            PRIMARY_COLOR.withOpacity(0.13),
            PRIMARY_COLOR.withOpacity(0.13)
          ];
          break;
        }
      case OrderStatuses.PICKED_UP:
        {
          colorsArray = [
            PRIMARY_COLOR,
            PRIMARY_COLOR,
            PRIMARY_COLOR,
            PRIMARY_COLOR.withOpacity(0.13)
          ];
          break;
        }
      case OrderStatuses.DELIVERED_AND_PAID:
        {
          colorsArray = [
            Colors.green,
            Colors.green,
            Colors.green,
            Colors.green,
          ];
          break;
        }
      case OrderStatuses.CANCELLED_BY_CUSTOMER:
        {
          colorsArray = [RED_COLOR, RED_COLOR, RED_COLOR, RED_COLOR];
          break;
        }
      default:
        {
          colorsArray = [RED_COLOR, RED_COLOR, RED_COLOR, RED_COLOR];
        }
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ScreenIndicator(color: colorsArray[0]),
            SizedBox(width: 5),
            ScreenIndicator(color: colorsArray[1]),
            SizedBox(width: 5),
            ScreenIndicator(color: colorsArray[2]),
            SizedBox(width: 5),
            ScreenIndicator(color: colorsArray[3])
          ],
        ),
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Text("${orderStatus.split('_').join(" ").toLowerCase()}",
              style: TextStyle(
                  fontSize: 14,
                  color: colorsArray[0],
                  fontWeight: FontWeight.bold))
        ])
      ],
    );
  }
}

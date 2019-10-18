import 'package:elec_mart_customer/components/app_title.dart';
import 'package:elec_mart_customer/components/horizontal_list_item.dart';
import 'package:elec_mart_customer/models/InventoryItemModel.dart';
import 'package:elec_mart_customer/models/VendorModel.dart';
import 'package:flutter/material.dart';

import 'item_detail.dart';

class OfferScreen extends StatefulWidget {
  final List<InventoryItemModel> inventories;
  final VendorModel vendor;
  final String image;

  OfferScreen({this.image, this.inventories, this.vendor});

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: layout(),
    );
  }

  Widget layout() {
    return ListView(
      children: <Widget>[
        AppTitleWidget(),
        Container(
            padding: EdgeInsets.all(24), child: Image.network(widget.image)),
        Container(
          child: ListView.separated(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 10),
            padding: EdgeInsets.all(8.0),
            itemCount: widget.inventories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: widget.inventories[index].inStock <= 0
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemDetail(
                                inventory: widget.inventories[index],
                                vendor: widget.vendor),
                          ),
                        );
                      },
                child: HorizontalListItem(
                  outOfStock: widget.inventories[index].inStock <= 0,
                  id: widget.inventories[index].id,
                  imageURL: widget.inventories[index].images,
                  name: widget.inventories[index].name,
                  mrpPrice: widget.inventories[index].originalPrice.toString(),
                  currentPrice:
                      widget.inventories[index].sellingPrice.toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

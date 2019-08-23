import 'package:elec_mart_customer/components/app_bar.dart';
import 'package:elec_mart_customer/components/drop_down_widget.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal>
    with SingleTickerProviderStateMixin {
  RangeValues rangeValues = RangeValues(0, 20);
  final List<String> dropdownValues = ["One", "Two", "Three", "Four", "Five"];
  bool isExpanded = false;
  String itemValue;

  AnimationController animationController;
  Animation<Offset> animationOffset;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    animationOffset = Tween<Offset>(end: Offset(0, 0), begin: Offset(0.0, -1.0))
        .animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: <Widget>[
          SlideTransition(
            position: animationOffset,
            child: Container(
              color: WHITE_COLOR,
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(margin: EdgeInsets.only(top: 65)),
                  filterOperations(),
                  rangeSliders(),
                  SizedBox(height: 5),
                  sortBy(),
                  SizedBox(height: 10),
                  buttonRow(),
                ],
              ),
            ),
          ),
          CustomAppBar(
            iconRight: isExpanded ? FeatherIcons.x : null,
            onFilterPressed: () {
              if (!isExpanded)
                animationController.forward();
              else
                animationController.reverse();
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget filterOperations() {
    return CustomTextField(
      labelText: "Search for items",
      onChanged: (val) {},
    );
  }

  Widget rangeSliders() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Price Range",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                child: RangeSlider(
                  values: rangeValues,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  activeColor: PRIMARY_COLOR,
                  inactiveColor: LIGHT_BLUE_COLOR,
                  onChanged: (RangeValues val) {
                    setState(() {
                      rangeValues = val;
                    });
                  },
                ),
              ),
            ],
          ),
          Text(
            "${rangeValues.start}- ${rangeValues.end}",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget sortBy() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Sort by",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropDownWidget(
            hint: "Price (low to high)",
            itemList: ["Price (low to high)", "Price (high to low)", "Newest"],
            onChanged: (value) {
              setState(() {
                itemValue = value;
              });
            },
            itemValue: itemValue,
          )
        ],
      ),
    );
  }

  Widget buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TeritoryButton(
          text: "Remove Filters",
        ),
        PrimaryButtonWidget(
          buttonText: "Apply Filters",
          onPressed: () {},
          icon: FeatherIcons.check,
        )
      ],
    );
  }
}

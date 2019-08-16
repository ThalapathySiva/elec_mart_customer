import 'package:elec_mart_customer/components/app_bar.dart';
import 'package:elec_mart_customer/components/primary_button.dart';
import 'package:elec_mart_customer/components/teritory_button.dart';
import 'package:elec_mart_customer/components/text_field.dart';
import 'package:elec_mart_customer/constants/Colors.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  RangeValues rangeValues = RangeValues(0, 0.5);
  final List<String> _dropdownValues = ["One", "Two", "Three", "Four", "Five"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomAppBar(),
          Container(margin: EdgeInsets.only(top: 10)),
          filterOperations(),
          rangeSliders(),
          sortBy(),
          buttonRow(),
        ],
      ),
    );
  }

  Widget filterOperations() {
    return CustomTextField();
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
          dropDown(),
        ],
      ),
    );
  }

  Widget dropDown() {
    return DropdownButton(
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (String value) {},
      isExpanded: false,
      hint: Text(
        'Price (low to high)',
        style: TextStyle(fontWeight: FontWeight.bold),
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
          icon: Icons.done,
        )
      ],
    );
  }
}

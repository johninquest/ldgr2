import 'package:flutter/material.dart';
import 'colors.dart';

const PageHeaderStyle = TextStyle(
    fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2.0);

const AppBarTitleStyle =
    TextStyle(wordSpacing: 3.0, letterSpacing: 1.0, fontSize: 18.0);

const BodyStyle =
    TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold);

const DropdownListStyle = TextStyle(fontWeight: FontWeight.normal);

const ListTitleStyle = TextStyle(fontWeight: FontWeight.bold);
const ListItemStyle = TextStyle(fontSize: 5.0);
const TableItemStyle = TextStyle(fontSize: 14.0);

class StyleHandler {
  tableCategoryStyle(String category) {
    if (category == 'expenditure') {
      return TextStyle(color: myRed, fontWeight: FontWeight.bold);
    }
    if (category == 'income') {
      return TextStyle(color: myTeal, fontWeight: FontWeight.bold);
    }
  }

  paymentStatus(String ps) {
    if (ps == 'paid') {
      return TextStyle(color: blackColor);
    }
    if (ps == 'unpaid') {
      return TextStyle(color: myAmber);
    }
  }
}

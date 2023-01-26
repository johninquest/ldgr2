import 'package:flutter/material.dart';
import '../pages/expense/expense_list.dart';
import '../pages/home.dart';
import '../utils/router.dart';
import '../styles/colors.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: primaryColor,
      /* selectedItemColor: blackColor,
      unselectedItemColor: blackColor,
      selectedIconTheme: IconThemeData(color: Colors.black), */
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: blackColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box_outlined,
            color: blackColor,
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt_outlined,
            color: blackColor,
          ),
          label: 'List',
        ),
      ],
      onTap: (index) => afterTap(index),
    );
  }

  void afterTap(int currentIndex) {
    if (currentIndex == 0) {
      PageRouter().navigateToPage(HomePage(), context);
    }
    if (currentIndex == 1) {
      print('Tapped add button');
    }
    if (currentIndex == 2) {
      PageRouter().navigateToPage(ExpenseListPage(), context);
    }
  }
}

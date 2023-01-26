import 'package:flutter/material.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../styles/colors.dart';
import '../../styles/style.dart';
import '../../utils/router.dart';
import 'add_income.dart';

class IncomeListPage extends StatelessWidget {
  const IncomeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'income list'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Income list page!'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Enter new income',
        child: Icon(
          Icons.add,
        ),
        onPressed: () =>
            PageRouter().navigateToPage(const InputIncomePage(), context),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

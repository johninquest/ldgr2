import 'package:flutter/material.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../styles/colors.dart';
import 'dart:developer';

import '../../styles/style.dart';

class TaxListPage extends StatelessWidget {
  const TaxListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'tax list'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('List of tax categories'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Enter new tax category',
        child: Icon(
          Icons.add,
        ),
        onPressed: () => log('Tapped add tax button!'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

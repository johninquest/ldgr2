import 'package:flutter/material.dart';
import '../shared/bottom_nav_bar.dart';

class AddOptionsPage extends StatelessWidget {
  const AddOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Add options!'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

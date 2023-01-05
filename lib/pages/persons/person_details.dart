import 'package:flutter/material.dart';
import 'package:ldgr2/shared/bottom_nav_bar.dart';

class PersonDetailsPage extends StatelessWidget {
  const PersonDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer details'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Customer details page!'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddPersonPage extends StatelessWidget {
  const AddPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add customer'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Add customer page!'),
      ),
    );
  }
}

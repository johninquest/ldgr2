import 'package:flutter/material.dart';
import '../../styles/style.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add contact'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Add contact page!'),
      ),
    );
  }
}

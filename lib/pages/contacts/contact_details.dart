import 'package:flutter/material.dart';
import '../../styles/style.dart';

class ContactDetailsPage extends StatelessWidget {
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'contact details'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Contact details page!'),
      ),
    );
  }
}

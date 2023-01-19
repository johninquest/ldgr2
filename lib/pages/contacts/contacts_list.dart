import 'package:flutter/material.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../styles/colors.dart';
import '../../styles/style.dart';
import '../../utils/router.dart';
import 'add_contact.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'contacts'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('List of contacts page!'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Enter new person',
        child: Icon(
          Icons.add,
        ),
        onPressed: () =>
            PageRouter().navigateToPage(const AddContactPage(), context),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

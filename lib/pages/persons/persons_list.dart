import 'package:flutter/material.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../styles/colors.dart';
import '../../utils/router.dart';
import 'add_person.dart';

class PersonsListPage extends StatelessWidget {
  const PersonsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persons'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('List of persons page!'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Enter new person',
        child: Icon(
          Icons.add,
        ),
        onPressed: () =>
            PageRouter().navigateToPage(const AddPersonPage(), context),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
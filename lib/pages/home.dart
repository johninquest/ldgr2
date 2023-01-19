import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../utils/router.dart';
import '../shared/bottom_nav_bar.dart';
import '../shared/dialogs.dart';
import '../shared/side_nav_bar.dart';
import 'expense/expense_list.dart';
import 'income/income_list.dart';
import 'contacts/contacts_list.dart';
import 'stock/stock_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            child: IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => LogoutDialog(),
                  barrierDismissible: true),
              icon: Icon(Icons.logout_outlined),
              tooltip: 'Log out',
            ),
          )
        ],
      ),
      drawer: SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(bottom: 25.0),
              child: ElevatedButton(
                onPressed: () =>
                    PageRouter().navigateToPage(ContactsListPage(), context),
                child: Text('CONTACTS',
                    style: TextStyle(
                        fontSize: 20.0, letterSpacing: 3.0, color: blackColor)),
              ),
            ),
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(bottom: 25.0),
              child: ElevatedButton(
                onPressed: () =>
                    PageRouter().navigateToPage(ExpenseListPage(), context),
                child: Text(
                  'EXPENSES',
                  style: TextStyle(
                      fontSize: 20.0, letterSpacing: 3.0, color: blackColor),
                ),
                // style: ElevatedButton.styleFrom(backgroundColor: blackColor),
              ),
            ),
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(bottom: 25.0),
              child: ElevatedButton(
                  onPressed: () =>
                      PageRouter().navigateToPage(IncomeListPage(), context),
                  child: Text('INCOME',
                      style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 3.0,
                          color: blackColor)),
                  style: ElevatedButton.styleFrom()),
            ),
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(bottom: 25.0),
              child: ElevatedButton(
                onPressed: () =>
                    PageRouter().navigateToPage(StockOverviewPage(), context),
                /*  onPressed: () => showDialog(
                      context: context,
                      builder: (_) => InfoDialog('Coming soon!'),
                      barrierDismissible: true), */
                child: Text('STOCK',
                    style: TextStyle(
                        fontSize: 20.0, letterSpacing: 3.0, color: blackColor)),
                // style: ElevatedButton.styleFrom(backgroundColor: secondaryColor)
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

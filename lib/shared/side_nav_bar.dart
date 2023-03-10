import 'package:flutter/material.dart';
import 'package:ldgr2/pages/settings.dart';
import '../pages/about.dart';
import '../pages/inputs/business_info.dart';
import '../pages/inputs/country.dart';
import '../pages/taxes/tax_list.dart';
import '../styles/colors.dart';
import '../utils/router.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String? _currentUserName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: primaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*  Icon(
                      Icons.person,
                      // color: Colors.white,
                      size: 50.0,
                    ), */
                    Text(
                      _currentUserName ?? '',
                      style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                  ],
                )),
/* 
            ListTile(
              leading: Icon(
                Icons.contacts,
              ),
              title: Text(
                'Contacts',
              ),
              onTap: () =>
                  PageRouter().navigateToPage(ContactsListPage(), context),
            ), */
            ListTile(
              leading: Icon(
                Icons.business,
              ),
              title: Text(
                'Business',
              ),
              onTap: () =>
                  PageRouter().navigateToPage(InputPersonPage(), context),
            ),
            ListTile(
                leading: Icon(
                  Icons.language,
                ),
                title: Text(
                  'Currency',
                ),
                onTap: () =>
                    PageRouter().navigateToPage(CountryPage(), context)),
            ListTile(
              leading: Icon(
                Icons.calculate,
              ),
              title: Text(
                'Taxes',
              ),
              onTap: () => PageRouter().navigateToPage(TaxListPage(), context),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
              ),
              title: Text(
                'Info',
              ),
              onTap: () => PageRouter().navigateToPage(AboutPage(), context),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
              ),
              title: Text(
                'Settings',
              ),
              onTap: () => PageRouter().navigateToPage(SettingsPage(), context),
            ),
          ],
        ),
      ),
    );
  }
}

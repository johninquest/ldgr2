import 'package:flutter/material.dart';
import '../pages/about.dart';
import '../pages/inputs/business_info.dart';
import '../pages/inputs/country.dart';
import '../pages/persons/person_details.dart';
import '../pages/persons/persons_list.dart';
import '../styles/colors.dart';
import '../utils/router.dart';
import 'dart:developer';

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
/*             ListTile(
              leading: Icon(
                Icons.bar_chart,
              ),
              title: Text(
                'Analysis',
              ),
              onTap: () => PageRouter().navigateToPage(AnalysisPage(), context),
            ), */
            ListTile(
              leading: Icon(
                Icons.group,
              ),
              title: Text(
                'Customers',
              ),
              onTap: () =>
                  PageRouter().navigateToPage(PersonsListPage(), context),
            ),
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
                  'Country',
                ),
                onTap: () =>
                    PageRouter().navigateToPage(CountryPage(), context)),
            ListTile(
              leading: Icon(
                Icons.info_outline,
              ),
              title: Text(
                'Info',
              ),
              onTap: () => PageRouter().navigateToPage(AboutPage(), context),
            ),
            ListTile(
              leading: Icon(
                Icons.settings_outlined,
              ),
              title: Text(
                'Settings',
              ),
              onTap: () => log('Tapped settings button'),
            ),

            /* ListTile(
              leading: Icon(
                Icons.logout,
                color: myBlue,
              ),
              title: Text(
                'Log out',
                style: TextStyle(color: myBlue),
              ),
              onTap: () {
                // FirebaseAuthService().logoutUser();
                SharedPreferencesHelper().removeData('currentUserData');
                PageRouter().navigateToPage(LoginPage(), context);
              },
            ), */
          ],
        ),
      ),
    );
  }
}

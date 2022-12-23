import 'package:flutter/material.dart';
import '../db/sp_helper.dart';
import '../pages/about.dart';
import '../pages/analysis/overview.dart';
import '../pages/inputs/business_info.dart';
import '../pages/inputs/country.dart';
import '../pages/users/user_list.dart';
import '../styles/colors.dart';
import '../utils/preprocessor.dart';
import '../utils/router.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String? _currentUserName;
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper().readData('currentUserData').then((val) {
      if (val != null) {
        setState(() {
          _currentUserName = DataParser().strToMap(val)['name'];
          String _currentUserRole = DataParser().strToMap(val)['role'];
          if (_currentUserRole == 'owner' || _currentUserRole == 'admin') {
            _isVisible = true;
          }
        });
      }
    });
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
                    Icon(
                      Icons.person,
                      // color: Colors.white,
                      size: 50.0,
                    ),
                    Text(
                      _currentUserName ?? '',
                      style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                  ],
                )),
            ListTile(
              leading: Icon(
                Icons.bar_chart,
              ),
              title: Text(
                'Analysis',
              ),
              onTap: () => PageRouter().navigateToPage(AnalysisPage(), context),
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
            /* ListTile(
              leading: Icon(
                Icons.category,
                color: myBlue,
              ),
              title: Text(
                'Items',
                style: TextStyle(color: myBlue),
              ),
              // onTap: () => PageRouter().navigateToPage(ItemsPage(), context),
              onTap: () => showDialog(
                  context: context, 
                  builder: (_) => InfoDialog('Still under construction!'), 
                  barrierDismissible: false),
            ), */
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
            Visibility(
              visible: _isVisible,
              child: ListTile(
                leading: Icon(
                  Icons.person_outline,
                ),
                title: Text(
                  'Users',
                ),
                onTap: () =>
                    PageRouter().navigateToPage(UserListPage(), context),
              ),
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

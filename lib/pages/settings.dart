import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shared/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/style.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.toUpperCase(),
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CurrentUser()],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class CurrentUser extends StatelessWidget {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(3.0),
              child: Text(
                'Offline mode',
                style: TextStyle(color: myLightRed),
              ),
            ),
          );
        } else {
          final _user = snapshot.data;
          /*  log('User => ${_user?.email}'); */
          return Center(
            child: Text(
              '${_user?.email}',
              style: TextStyle(color: myTeal),
            ),
          );
        }
      },
    );
  }
}
